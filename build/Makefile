SITE?=no-site
NAME?=new-rulepack

env:
	virtualenv .env
	source .env/bin/activate && pip install --upgrade pysigsci

template:
	mkdir -p templates
	cat template.json | sed -e "s/_SITE_/$(SITE)/" | sed -e "s/_NAME_/$(NAME)/" > templates/$(NAME).json

rulepack:
	source .env/bin/activate && ./generate-rulepack.sh $(NAME)
