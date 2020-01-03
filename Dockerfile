FROM openresty/openresty:1.15.8.1rc1-bionic

ADD https://releases.hashicorp.com/consul-template/0.22.0/consul-template_0.22.0_linux_amd64.tgz ./consul-template.tgz
RUN tar -xzf ./consul-template.tgz
RUN rm ./consul-template.tgz

RUN opm get bungle/lua-resty-template

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY ./templates ./templates
COPY ./config.hcl ./

EXPOSE 80

ENTRYPOINT [ "./consul-template", "-config", "./config.hcl" ]
