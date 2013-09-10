puppet module for scala
-----------------------

This module will install and manage scala

###Sample Usage

```puppet
include scala
```

Using with puppet apply (given module lives in /root/modules):

```bash
cd ~ && mkdir modules
cd ~/modules && git clone https://github.com/ashrithr/puppet_scala.git scala
puppet apply --modulepath=/root/modules/ -e "include scala"
```

Note: For puppet apply, modules should be located inside modules dir

**To install puppet (standalone)**:

1. Using wget:

```
wget -qO - https://raw.github.com/ashrithr/scripts/master/install_puppet_standalone.sh | bash
```

(OR)

2. Using curl:

```
bash <(curl -s https://raw.github.com/ashrithr/scripts/master/install_puppet_standalone.sh)
```
