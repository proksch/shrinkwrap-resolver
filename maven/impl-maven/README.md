This fork of the default `shrinkwrap-resolver-impl-maven` add logic that allows to capture artifactRepositories for resolved dependencies. To achieve this, a small (yet hacky) extension has been introduced to the `MAvenResolvedArtifactImpl` class.

This change was added directly to the state of the code at release version 3.1.4, so it should be fully compatible to other Shrinkwrap related packages.

### How do I deploy the patched version?

Normally you should not need to do this, as we provide it as a Maven package through this GitHub repository (`repository` branch).
For completeness and future documentation: a few simple steps have to be performed to deploy the package there.

1) run `mvn clean package` in the `maven/impl-maven` folder
2) edit the `deploy-to-local-repo.sh` script and run it to deploy to a local repository
3) Commit/push the local repository contents to the `repository` branch of this GitHub repository

It is convenient to have two checkouts of this repository, one on the `3.1.4-patched` branch, another one on the `repository` branch. This way, it is possible to directly deploy to the right folder.

### How to then use the package in my Maven project?

Three things are necessary. First, add a custom repository to you pom.xml

    <repositories>
        <repository>
            <id>github-shrinkwrap-resolver-patched</id>
            <url>https://github.com/fasten-project/shrinkwrap-resolver-patched/raw/repository</url>
        </repository>
    </repositories>

Second, include the patched version. We have renamed it to distinguish it from the original release.

    <dependency>
        <groupId>org.jboss.shrinkwrap.resolver</groupId>
        <artifactId>shrinkwrap-resolver-impl-maven-patched</artifactId>
        <version>3.1.4</version>
    </dependency>

Third, exclude the original dependency in one of its dependents to avoid a clash of classes.

    <dependency>
        <groupId>org.jboss.shrinkwrap.resolver</groupId>
        <artifactId>shrinkwrap-resolver-depchain</artifactId>
        <version>3.1.4</version>
        <type>pom</type>
        <exclusions>
            <exclusion>
                <groupId>org.jboss.shrinkwrap.resolver</groupId>
                <artifactId>shrinkwrap-resolver-impl-maven</artifactId>
            </exclusion>
        </exclusions>
    </dependency>

That's it.


