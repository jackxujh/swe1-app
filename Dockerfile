FROM python:3
ENV PYTHONUNBUFFERED=1

WORKDIR /code

RUN pip install --upgrade pip

COPY requirements.txt /code
RUN pip install -r requirements.txt

COPY manage.py /code
COPY .flake8 /code
COPY scripts /code/scripts
COPY mysite_swe1_app /code/mysite_swe1_app
COPY polls /code/polls

RUN cd /code
RUN python manage.py collectstatic --noinput
RUN chmod a+x /code/scripts/*.sh

# changing to non-root user breaks `coverage` command in docker
# see discussion https://github.com/nedbat/coveragepy/issues/915#issuecomment-574818558

# RUN useradd -m myuser
# USER myuser

CMD gunicorn mysite_swe1_app.wsgi --bind 0.0.0.0:$PORT