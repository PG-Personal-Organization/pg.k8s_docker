#!/usr/bin/env bash

# accounts
cd pg.accounts || exit
sh build.sh
cd ..

# api-gateway
cd pg.api-gateway || exit
sh build.sh
cd ..

# context-auth
cd pg.context-auth || exit
sh build.sh
cd ..

# payments
cd pg.payments || exit
sh build.sh
cd ..



