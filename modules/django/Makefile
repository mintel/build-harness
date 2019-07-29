## Run Django tests
django/test: pipenv
	$(WITH_PIPENV) ./manage.py migrate
	$(WITH_PIPENV) ./manage.py test -- -m "not postbuild"

## Run Django tests
django/test-post-build: pipenv
	$(WITH_PIPENV) ./manage.py migrate
	$(WITH_PIPENV) ./manage.py test -- -m "postbuild"

## Run Django check
django/check: pipenv
	DJANGO_SECRET_KEY=foobar $(WITH_PIPENV) ./manage.py check
