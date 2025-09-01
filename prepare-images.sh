#!/usr/bin/env bash

# api-gateway
cd pg.api-gateway || exit
sh build.sh
cd ..

# accounts
cd pg.accounts || exit
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



