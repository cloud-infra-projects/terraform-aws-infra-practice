# Terraform AWS Infra Practice

개인 연습용 Terraform 프로젝트.  
목표: **AWS 인프라를 코드로 선언하고, plan/apply로 재현**하는 흐름 익히기.

## ✅ 현재 단계 (Day 1)

- AWS 계정 & IAM 사용자 생성 (MFA, `AdministratorAccess`가 연결된 전용 사용자)
- AWS CLI 설정 (`aws configure`) 및 인증 확인
- Terraform 설치 및 초기화 (`terraform init`)
- **EC2 인스턴스 1대** 생성 성공 (기본 VPC 사용)

## 🧰 사양

- OS: Windows 11 (PowerShell)
- Terraform: v1.13.x
- AWS Provider: v6.x
- 리전: `ap-northeast-2` (Seoul)

## 📂 프로젝트 구조

.
├─ main.tf # EC2 예제 + 최신 AMI data source
├─ provider.tf # AWS provider 버전/리전/프로파일
├─ variables.tf # 실습 변수 (예: instance_type)
└─ .terraform.lock.hcl

## 🔐 자격 증명

- 로컬 저장소: `C:\Users\<USER>\.aws\credentials`, `C:\Users\<USER>\.aws\config`
- provider는 프로파일 사용:

```hcl
provider "aws" {
  region  = "ap-northeast-2"
  profile = "default"
}
```
