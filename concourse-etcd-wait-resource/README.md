# concourse-etcd-wait-resource
This is the docker image used for waiting a key in etcd exist with a value 

## Resource Definition
```yaml
resource_types:
- name: etcd-wait
  type: docker-image
  source:
    repository: evoila/concourse-etcd-wait-resource
    tag: latest
```

## Source
### As cache(Ftp server):
```yaml
resources:
- name: 
  type: etcd-wait
  source:
    cache:
      server:       % etcd server url
      pathPrefix:       % etcd key path prefix used no absulate path is get
```
### wait:
```yaml
resources:
- name:
  type: etcd-wait
  source:
    get:
      path:         % key path
      value:        % value to wait(grep regex)
```

### set:
```yaml
resources:
- name:
  type: etcd-wait
  source:
    set:
      path:         % key path
      value:        % value to set
```

