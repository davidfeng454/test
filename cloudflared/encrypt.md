🧩 一、使用 openssl enc（最常见且通用）
✅ 加密：
openssl enc -aes-256-cbc -salt -pbkdf2 -in tunnel1.txt -out tunnel1.enc.txt -k "mypassword"

✅ 解密：
openssl enc -d -aes-256-cbc -pbkdf2 -in tunnel1.enc.txt -out dec.txt -k "mypassword"