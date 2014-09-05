# Completely ignore non-RHEL based systems
{% if grains['os_family'] == 'RedHat' %}

include:
  - epel

{% if grains['osmajorrelease'][0] == '6' %}
  {% set pkg = {
    'rpm': 'http://archive.zfsonlinux.org/epel/zfs-release.el6.noarch.rpm',
  } %}
{% elif grains['osmajorrelease'][0] == '7' %}
  {% set pkg = {
    'rpm': 'http://archive.zfsonlinux.org/epel/zfs-release.el7.noarch.rpm',
  } %}
{% endif %}

zfs_release:
  pkg:
    - installed
    - sources:
      - zfs-release: {{ pkg.rpm }}
    - skip_verify: True
    - require:
      - pkg: epel_release

zfs:
  pkg.installed:
    - pkgs:
      - kernel-devel
      - zfs
    - require:
      - pkg: zfs_release

{% endif %}
