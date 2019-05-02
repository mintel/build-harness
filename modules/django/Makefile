## Run Django tests
django/test: python/env
	$(WITH_PIPENV) ./manage.py migrate
	$(WITH_PIPENV) ./manage.py test

## Run Django check
django/check: python/env
	DJANGO_SECRET_KEY=foobar $(WITH_PIPENV) ./manage.py check
