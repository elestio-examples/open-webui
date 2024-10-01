#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 60s;

target=$(docker-compose port open-webui 8080)

curl http://${target}/api/v1/auths/signup \
  -H 'accept: */*' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6,zh-CN;q=0.5,zh;q=0.4,ja;q=0.3' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'pragma: no-cache' \
  -H 'priority: u=1, i' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36' \
  --data-raw '{"name":"admin","email":"'${ADMIN_EMAIL}'","password":"'${ADMIN_PASSWORD}'","profile_image_url":"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAAAXNSR0IArs4c6QAABJFJREFUeF7tnF1oFFccxc/M7GwmMdZajVWpvkSptR9BNEIqVSvVUrQgpQ/VF0FEUYoUqvStVV9EFPRBLJQgCEVfxA9saRtF+4H4kIIExNbSKGihrSIaTZPZzyk7Y0NmYtzNrppzy9m3Ze/snjm/Ofd///eGWPfbnwugF40DloDQsAiFCAgXDwEh4yEgAsLmAJke1RABIXOATI4SIiBkDpDJUUIEhMwBMjlKiICQOUAmRwkREDIHyOQoIQJC5gCZHCVEQMgcIJOjhAgImQNkcpQQASFzgEyOEiIgZA6QyVFCBITMATI5SoiAkDlAJkcJERAyB8jkGJ0Qb+mXSE1/Z8DSIPcPsp3bkPvlIJnNlcsxFogzaR68N9thNU6L3W3+Rgf8jlWVO0A20lgg6dZPkX5lE2C7MUuD/lvwf/wQhT/OkFldmRxjgdQv/wrO5LbwLoP+m7DSzwCOBwRF5K4cQub8lsocIBtlJJBU8/uoa9sFq+7Z0M789W/hTGyB1TAlfF+88yv6T72NINdLZnd5OUYCqVuwB+6LawDLBgoZZLv2wpn8OpypC6PEGFzcjQNij2uGt/Qw7HEzIvP7/oT/w0Y4TXORnrM1mrZKqTG0uBsHxJ29DunWz2ClGkLjC39dQP/XK5BcdZla3I0D4i07gtS0ZdFkXMwhe+kAsp07wrexvsTQ4m4UEGfqG/AWfT5QvIPeG/DPrUPh5s8hEPeltUi3boPljol49fwO//RqFHu6y1dTkhFGAUn2Hsk6kawvKPjIXtyNbNc+ErvLyzAKSMPKs7AntETFPN+HbOd25C63x+4ytgIzsLgbAyTZeww3HSXHmVbcjQHiLf4Cqeb3Sv8NpJQP5H47jMxPmx86B9Sv+AbO8/Ojzwwr7kYAGdJ7ZO4ic+ET5LuPPhRIstaYVNyNAJJu+SjW9BVvd6HvxJJhK+SQnWCDirsRQB7VewxHJXbNoAay/DpndEfQA3FeeAvewv2w6ptqcirI3EHm/MfIXztZ0/c86YvpgdTN3wH35Q2AnarNC0OKOzUQy21E/fJTsCe8VhuMB1ebUNypgbgzVyHdthOWOzZawfb9HW61B9meigDZY6bAfXXzwLmJCZ07NZB471Hdlvrg7r5E8b/d4YqIjsIgWiB20xx4Sw7Cbpwe2VLl0jXZkwRlephRYBD7SVogQ3qP3uvwz65F8dbFEXmW3CEudfn57mPwv18/ou95WoNpgQz+I4aSGfmrx8Ot9mpeyZ6keO8q/I4PKLflKYEke49az8iTp4zVTn/VPAwjvYYSSHILvdbl6pBzEuLiTgck7D3e/Q72+FkPHq5H7+xW+gQmIbMWdzogyWPYx2Vc8pyEtbjTAan0if+/jhMQMrICIiBkDpDJUUIEhMwBMjlKiICQOUAmRwkREDIHyOQoIQJC5gCZHCVEQMgcIJOjhAgImQNkcpQQASFzgEyOEiIgZA6QyVFCBITMATI5SoiAkDlAJkcJERAyB8jkKCECQuYAmRwlREDIHCCTo4QICJkDZHKUEAEhc4BMjhIiIGQOkMlRQgSEzAEyOUoIGZB/Abe4lAMJb2YBAAAAAElFTkSuQmCC"}'

sed -i "s/^ENABLE_SIGNUP=True/ENABLE_SIGNUP=False/" ./.env
docker compose down;
docker compose up -d;
sleep 30s;