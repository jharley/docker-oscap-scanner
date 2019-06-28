# docker-oscap-scanner

Available on Docker Hub as [jharley/oscap-scanner](https://hub.docker.com/r/jharley/oscap-scanner).

A utility container to assist with doing remote OSCAP scans. The default entrypoint is the [oscap-ssh](https://github.com/OpenSCAP/openscap/blob/maint-1.3/utils/oscap-ssh) wrapper script.

The XML manifests are installed via the Ubuntu packages and are installed in the container at `/usr/share/scap-security-guide`.

The default SSH configuration passed to `oscap-ssh` disables host key verification to remove the need to do a host scan prior to running the utility. This can be overriden by setting `SSH_ADDITIONAL_OPTIONS`. The same variable is configured expecting that the SSH private key will be mounted in as `/ssh-identity`.

## Example Usage

The following performs an OSCAP scan of an Ubuntu 16.04 host using the "ANSSI NP-NT28 (High)" profile:

```shell
docker run -v `pwd`:/data -v ./my-ssh-identity.pem:/ssh-identity \
  jharley/oscap-scanner --sudo ubuntu@target 22 xccdf \
  eval --results /data/target-results-`date "+%Y-%m-%d-%s"`.xml \
  --report /data/target-report-`date "+%Y-%m-%d-%s"`.html \
  --profile xccdf_org.ssgproject.content_profile_anssi_np_nt28_high \
  /usr/share/scap-security-guide/ssg-ubuntu1604-ds.xml
```
