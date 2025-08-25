# VPC 네트워크의 뼈대 전체를 한 번에 만든다
# VPC → (IGW) → 퍼블릭/프라이빗 서브넷 → NAT(옵션) → 라우팅 테이블과 연결

# 1. 테라폼 프로바이더 선언
# -> 테라폼 프로바이더가 뭔지

# 2. 입력값 기반 준비(데이터/로컬) : AZ 목록, 로컬 변수

# 3. 리소스 본체
# - VPC & IGW
# - 퍼블릭 / 프라이빗 서브넷
# - NAT(EIP, NAT GW)
# - 라우팅 테이블 / 라우트 / 서브넷-RT 연결

## 선언부
## 버전 충돌화 방지

terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}

## AZ을 동적으로 가져오기
## 서울(ap-northeast-2)은 apne2a,b,c,d 등인데, 계정/리전에 따라 조금씩 다르기 때문에 하드코딩 X

data "aws_availability_zones" "available" {}

## 사용할 AZ를 잘라쓰기
## aws 가용영역을 n개 슬라이스 -> 가용성을 위해서

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, var.az_count)
}

## VPC : 전체 IP 대역(예: 10.0.0.0/16) 정의
## DNS 옵션 : 내부 리졸빙/호스트네임(EC2 Private DNS) 쓰려고 거의 항상 켜둠
## IGW : 퍼블릭 서브넷이 인터넷 나가려면 반드시 필요함

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(var.tags, { Name = "${var.name}-vpc" })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = merge(var.tags, { Name = "${var.name}-igw" })
}



