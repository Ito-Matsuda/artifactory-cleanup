FROM ubuntu:20.04

#Install utilities here
#yq
#kubectl

#Copy files here

# Grant files execute here
RUN chmod +x run-job.sh

RUN find ./ -type f -iname "*.sh" -exec chmod +x {} \;

CMD ["run-job.sh"]