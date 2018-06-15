# concourse-maven-resource
Dies ist das Docker image welches für das builden und cachen der jar in der Concourse Pipeline verwendet wird.

## Einrichtung
```yaml
resource_types:
- name: maven-resource
  type: docker-image
  source:
    repository: evoila/concourse-mvn-resource
    tag: latest
```

## Verwendung
Als Cache(Ftp server):
```yaml
resources:
- name: 
  type: maven-resource
  source:
    cache:
      username:     % ftp benutzername    
      password:     % ftp passwort
      server:       % ftp server url
      path:         % ftp remote pfad 
      file:         % ftp remote file name
      localPath:    % local pfad, selbe wie name
      excludeCache: % files die nicht in den cache kommen
        - de/evoila % schließe groub de.evoila aus weil generierte jar cache dauerhat wachsen lässt
```
Zum Downloaden von jar:
```yaml
resources:
- name:
  type: maven-resource
  source:
    get:
      username:     % ftp benutzername
      password:     % ftp passwort
      repository:   % ftp server url
      group:        % group id
      artifact:     % artifact id
      fileName:     % lokalen namen der verwendet wird
      lastupdate: 1 % Benutze update Datum um Änderungen auch bei gleiche version zu erkennen 
```

builden von jar deklaration:
```yaml
resources:
- name: (( grab  meta.resource.maven.name ))
  type: maven-resource
  source:
    pom:
      add: 
      - pom.xml: file % Datei dessen inhalt genutzt wird um die Pom zu erweitern format wird später erklärt
    privateRepos:  % gerneriert m2 settings.xml
    - repo:
        id:        % muss mit deploment in pom.xml übereinstimmen
        url:       % ftp server url 
        username:  % ftp server benutzername
        password:  % ftp server passwort
    params:
    - name: value  % Parameter die über PARAMS[name] im bashscript adressiert werden können
```
builden von jar put:
```yaml
put:
  params:
    pom:
      file: git-osb-samba/pom.xml % Startpunkt zur Ersetzung versionsnummern in script mit  
    script:                     % script welches zum builden nach erweitern der pom zum builden ausgeführt wird.
    updateCache: true            % soll der cache aktualisiert werden, default false
    version:                      % versionsfile oder nummer von jar in bash VERSION[main]
    versions:
    - name: value                 %  versionsfile oder nummer in bash VERSION[name]
    params:                       % paremeter in bash PARAMS[name]
    - name: value
```


Fileformat pom.add:
```yaml
path: /project/build/pluginManagement/plugins % pfad ohne platzhalter in pom, muss existieren
insert:                                       % folgende ausdruck wird als xml in den Pfad engefügt
  plugin:
    groupId: org.apache.maven.plugins
    artifactId: maven-deploy-plugin
```
erzeugt in der pom:
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
