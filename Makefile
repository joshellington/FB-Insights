BRANCH=$(shell git status|grep "On branch" | cut -f4 -d" ")

default:
	@echo $(BRANCH)

pull:
	 rsync --exclude-from=rsync.exclude -rcv josh@184.106.67.158:/var/www/fb-insights-app/ ./

fakepull:
	 rsync --exclude-from=rsync.exclude -rcvn josh@184.106.67.158:/var/www/fb-insights-app/./

push:
ifeq ($(BRANCH),master)
	 rsync --exclude-from=rsync.exclude -rcv ./ josh@184.106.67.158:/var/www/fb-insights-app/
else
	 @echo "Push must be done from master foo!"
endif

push_delete:
ifeq ($(BRANCH),master)
	 rsync --exclude-from=rsync.exclude -rcv --delete ./ josh@184.106.67.158:/var/www/fb-insights-app/
else
	 @echo "Push must be done from master foo!"
endif

fakepush:
	rsync --exclude-from=rsync.exclude -rcvn ./ josh@184.106.67.158:/var/www/fb-insights-app/

fakepush_delete:
	rsync --exclude-from=rsync.exclude -rcvn --delete ./ josh@184.106.67.158:/var/www/fb-insights-app/

stafgepull:
	 rsync --exclude-from=rsync.exclude -rcv josh@184.106.67.158:/var/www/fb-insights-app/ ./

stagefakepull:
	 rsync --exclude-from=rsync.exclude -rcvn josh@184.106.67.158:/var/www/fb-insights-app/./

stagepush:
ifeq ($(BRANCH),stage)
	 rsync --exclude-from=rsync.exclude -rcv ./ josh@184.106.67.158:/var/www/fb-insights-app/
else
	 @echo "Push must be done from master foo!"
endif

stagepush_delete:
ifeq ($(BRANCH),master)
	 rsync --exclude-from=rsync.exclude -rcv --delete ./ josh@184.106.67.158:/var/www/fb-insights-app/
else
	 @echo "Push must be done from master foo!"
endif

stagefakepush:
	rsync --exclude-from=rsync.exclude -rcvn ./ josh@184.106.67.158:/var/www/fb-insights-app/

stagefakepush_delete:
	rsync --exclude-from=rsync.exclude -rcvn --delete ./ josh@184.106.67.158:/var/www/fb-insights-app/