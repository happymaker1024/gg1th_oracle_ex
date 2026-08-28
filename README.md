# gg1th_oracle_ex

# 1. 오라클 서버 설치

# 2. db 클라이언트 설치(dbvear)

# 3. sql 기본 실습

# 4. python + oracle db 연동
## oracle 라이브러리 설치
```
uv add oracledb
```

## 설치 확인하기
```
uv pip show oracledb
```

## jupyter와 가상환경 연동하기
- ipykernel 설치
```
uv add ipykernel
```
- 가상환경 등록하기
```
uv run python -m ipykernel install --user --name=.venv
```