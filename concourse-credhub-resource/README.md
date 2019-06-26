# concourse-maven-resource
This is the docker image used for building, caching and get the jar in the Concourse pipeline. 

## Resource Definition
```yaml
resource_types:
- name: maven-resource
  type: docker-image
  source:
    repository: evoila/concourse-mvn-resource
    tag: latest
```

## Source
### As cache(Ftp server):
```yaml
resources:
- name: 
  type: maven-resource
  source:
    cache:
      username:     % ftp username   
      password:     % ftp password
      server:       % ftp server url
      path:         % ftp remote path 
      file:         % ftp remote file name
      localPath:    % local path to save file
      excludeCache: % files do not chache in tar file
        - de/evoila % exclude group de.evoila, this group build from resource 
```
### Get jar:
```yaml
resources:
- name:
  type: maven-resource
  source:
    get:
      username:     % ftp username
      password:     % ftp password
      repository:   % ftp server url
      group:        % group id
      artifact:     % artifact id
      fileName:     % local file name for jar
      lastupdate: 1 % use update date for check version changes, not only version number 
```

### Build jar:
```yaml
resources:
- name: 
  type: maven-resource
  source:
    pom:
      add: 
      - pom.xml: file % pom file to make changes
    privateRepos:  % generate repository settings in  m2 settings.xml
    - repo:
        id:        % the same used in  pom.xml
        url:       % ftp server url 
        username:  % ftp server username
        password:  % ftp server password
    params:
    - name: value  % define parms can git in bash script with PARAMS[name]
```

## Put
builden von jar put:
```yaml
put:
  params:
    pom:
      file: git-osb-samba/pom.xml % pom to begin replace version number 
    script:                     % path to bashscript call mvn
    updateCache: true            % update cache, default false
    version:                      % versionsfile or number for jar, reference in bash with VERSION[main]
    versions:
    - name: value                 %  versionsfile or number, reference in bash with VERSION[name]
    params:                       % params in bash reference PARAMS[name]
    - name: value
```


File format pom.add:
```yaml
path: /project/build/pluginManagement/plugins % patch without placeholder in pom, musst exist
insert:                                       % the next line add as xml child from path 
  plugin:
    groupId: org.apache.maven.plugins
    artifactId: maven-deploy-plugin
```
create in the pom:
```xml
<project>
  <build>
    <pluginManagement>
      <plugins>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-deploy-plugin</artifactId>
      </plugins>
    </pluginManagement>
  </build>
</project>
```
