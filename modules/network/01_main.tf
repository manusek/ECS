#################
# VPC
#################

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name    = "${var.project_name}-vpc"
    Project = var.project_name
    Owner   = var.owner
  }
}


################
# Subnets
################

# Public Subnets
resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr1
  availability_zone = var.az1

  tags = {
    Name    = "${var.project_name}-public-subnet-1"
    Project = var.project_name
    Owner   = var.owner
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr2
  availability_zone = var.az2

  tags = {
    Name    = "${var.project_name}-public-subnet-2"
    Project = var.project_name
    Owner   = var.owner
  }
}

# Private Subnets
resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr3
  availability_zone = var.az1

  tags = {
    Name    = "${var.project_name}-private-subnet-1"
    Project = var.project_name
    Owner   = var.owner
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr4
  availability_zone = var.az2

  tags = {
    Name    = "${var.project_name}-private-subnet-2"
    Project = var.project_name
    Owner   = var.owner
  }
}


################
# Internet Gateway
################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "${var.project_name}-igw"
    Project = var.project_name
    Owner   = var.owner
  }
}


################
# NAT Gateways
################

#EIP 1
resource "aws_eip" "nat1" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name    = "${var.project_name}-nat-eip1"
    Project = var.project_name
    Owner   = var.owner
  }
}

#EIP 2
resource "aws_eip" "nat2" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name    = "${var.project_name}-nat-eip2"
    Project = var.project_name
    Owner   = var.owner
  }
}

#NAT Gateway 1
resource "aws_nat_gateway" "ngw1" {
  allocation_id = aws_eip.nat1.id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name    = "${var.project_name}-ngw1"
    Project = var.project_name
    Owner   = var.owner
  }

  depends_on = [aws_internet_gateway.igw]
}

#NAT Gateway 2
resource "aws_nat_gateway" "ngw2" {
  allocation_id = aws_eip.nat2.id
  subnet_id     = aws_subnet.public2.id

  tags = {
    Name    = "${var.project_name}-ngw2"
    Project = var.project_name
    Owner   = var.owner
  }

  depends_on = [aws_internet_gateway.igw]
}


################
# Route Tables
################    

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.default_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name    = "${var.project_name}-public-rt"
    Project = var.project_name
    Owner   = var.owner
  }
}

# Private Route Tables
resource "aws_route_table" "private_rt1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.default_cidr
    gateway_id = aws_nat_gateway.ngw1.id
  }

  tags = {
    Name    = "${var.project_name}-private-rt"
    Project = var.project_name
    Owner   = var.owner
  }
}

resource "aws_route_table" "private_rt2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.default_cidr
    gateway_id = aws_nat_gateway.ngw2.id
  }

  tags = {
    Name    = "${var.project_name}-private-rt"
    Project = var.project_name
    Owner   = var.owner
  }
}


################
# Route Table Associations            
################

# Public subnets assoc
resource "aws_route_table_association" "public1_assoc" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public2_assoc" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_rt.id
}

# Private subnets assoc
resource "aws_route_table_association" "private1_assoc" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private_rt1.id
}

resource "aws_route_table_association" "private2_assoc" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private_rt2.id
}