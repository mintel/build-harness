## Run Django tests
django/test: pipenv
	$(PIPENV_RUN) ./manage.py migrate
	$(PIPENV_RUN) ./manage.py test

## Run Django check
django/check: pipenv
	DJANGO_SECRET_KEY=foobar $(PIPENV_RUN) ./manage.py check
