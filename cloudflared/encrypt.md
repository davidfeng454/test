🧩 一、使用 openssl enc（最常见且通用）
cd cloudflared
touch linux1.txt
touch linux2.txt
touch windows1.txt
touch windows2.txt

✅ 加密：

openssl enc -aes-256-cbc -salt -pbkdf2 -in tunnel1.txt -out tunnel1.enc.txt -k "mypassword"
cd cloudflared
mypassword=
openssl enc -aes-256-cbc -salt -pbkdf2 -in linux1.txt -out linux1.enc.txt -k $mypassword
openssl enc -aes-256-cbc -salt -pbkdf2 -in linux2.txt -out linux2.enc.txt -k $mypassword
openssl enc -aes-256-cbc -salt -pbkdf2 -in windows1.txt -out windows1.enc.txt -k $mypassword
openssl enc -aes-256-cbc -salt -pbkdf2 -in windows2.txt -out windows2.enc.txt -k $mypassword

✅ 解密：
openssl enc -d -aes-256-cbc -pbkdf2 -in tunnel1.enc.txt -out dec.txt -k "mypassword"