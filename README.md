docker-lutim
============

Docker for lutim (Let's Upload That Image) - https://github.com/ldidry/lutim

Before build the image, change the configuration in `lutim.conf`

If you want to store images on the host use -v option:
	 `docker run --rm -p 80:80 -v /pathonthehost:/srv/lutim/files -t philalex/docker-lutim`
`pathonthehost` must be by writable by `www-data`

**/!\ Warning**
If you run the image with -P, shortlinks don't work (HTTP port is missing in the link). You have to run it with -p 80:80
	 `docker run --rm -p 80:80 -t philalex/docker-lutim`