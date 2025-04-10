FROM python:3.11-slim

WORKDIR /apicode

COPY requirements.txt x/
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 4000

CMD [ "python", "backend_app.py"]