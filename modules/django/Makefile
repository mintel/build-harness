## Run Django tests
django/test: pipenv
	$(WITH_PIPENV) ./manage.py migrate
	$(WITH_PIPENV) ./manage.py test

## Run Django check
django/check: pipenv
	DJANGO_SECRET_KEY=foobar $(WITH_PIPENV) ./manage.py check
