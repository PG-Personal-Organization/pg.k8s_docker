echo "⏳ Sleeping 2s to let schemas initialize..."
sleep 2

echo "📦 Seeding initial data into Postgres..."

kubectl exec -i deploy/postgres -- \
  psql -U pg -d pgdb <<'EOF'
-- ==== Context-Auth users ====

-- Insert admin user with bcrypt password (admin123)
INSERT INTO users (id, username, password, enabled)
VALUES ('00000000-0000-0000-0000-000000000001',
        'admin',
        '$2a$08$xTWXdXUwFfVuuqK5j67ZQ.gSL2Lig0Fx375NuQt6Veo2f/KKMQkV6',
        true);

-- Insert normal user with bcrypt password (secret)
INSERT INTO users (id, username, password, enabled)
VALUES ('00000000-0000-0000-0000-000000000002',
        'user',
        '$2a$08$BP6zIu9QMra.8BUCh6E/su7FHAIgiRlk/jj7mxpPZeV/E55jDV2M2',
        true);

-- Assign roles (ADMIN, USER)
INSERT INTO users_roles (users_id, roles)
VALUES ('00000000-0000-0000-0000-000000000001', 'ADMIN'),
       ('00000000-0000-0000-0000-000000000001', 'USER'),
       ('00000000-0000-0000-0000-000000000001', 'ACCOUNTANT'),
       ('00000000-0000-0000-0000-000000000002', 'USER'),
       ('00000000-0000-0000-0000-000000000002', 'ACCOUNTANT');

-- ==== Accounts ====

-- === Accounts ===
INSERT INTO accounts (account_id, account_number, name, multi_currency, blocked, currencies)
VALUES ('acc-0001', '1000000000001', 'Main Corporate Account 1', true, false, '{PLN,USD,EUR,CAD,GBP,CHF}'),
       ('acc-0002', '1000000000002', 'Main Corporate Account 2', true, false, '{PLN,USD,EUR,CAD,GBP,CHF}'),
       ('acc-0003', '1000000000003', 'Operations Account 1', true, false, '{PLN,USD,EUR,CAD,GBP,CHF}'),
       ('acc-0004', '1000000000004', 'Operations Account 2', true, false, '{PLN,USD,EUR,CAD,GBP,CHF}'),
       ('acc-0005', '1000000000005', 'R&D Account', true, false, '{PLN,USD,EUR,CAD,GBP,CHF}'),
       ('acc-0006', '1000000000006', 'Marketing Account', true, false, '{PLN,USD,EUR,CAD,GBP,CHF}'),
       ('acc-0007', '1000000000007', 'Sales Account 1', true, false, '{PLN,USD,EUR,CAD,GBP,CHF}'),
       ('acc-0008', '1000000000008', 'Sales Account 2', true, false, '{PLN,USD,EUR,CAD,GBP,CHF}'),
       ('acc-0009', '1000000000009', 'Client Settlements 1', true, false, '{PLN,USD,EUR,CAD,GBP,CHF}'),
       ('acc-0010', '1000000000010', 'Client Settlements 2', true, false, '{PLN,USD,EUR,CAD,GBP,CHF}'),
       ('acc-0011', '1000000000011', 'Payroll Account 1', true, false, '{PLN,USD,EUR,CAD,GBP,CHF}'),
       ('acc-0012', '1000000000012', 'Payroll Account 2', true, false, '{PLN,USD,EUR,CAD,GBP,CHF}'),
       ('acc-0013', '1000000000013', 'Treasury Account 1', true, false, '{PLN,USD,EUR,CAD,GBP,CHF}'),
       ('acc-0014', '1000000000014', 'Treasury Account 2', true, false, '{PLN,USD,EUR,CAD,GBP,CHF}'),
       ('acc-0015', '1000000000015', 'Investments Account 1', true, false, '{PLN,USD,EUR,CAD,GBP,CHF}'),
       ('acc-0016', '1000000000016', 'Investments Account 2', true, false, '{PLN,USD,EUR,CAD,GBP,CHF}');

-- === Balances ===
-- Each account has balances in PLN, USD, EUR, CAD, GBP, CHF
INSERT INTO accounts_balances (balance_id, account_id, currency, balance, booked_balance)
VALUES
    -- acc-0001
    ('bal-0001-PLN', 'acc-0001', 'PLN', 100000000, 0),
    ('bal-0001-USD', 'acc-0001', 'USD', 25000000, 0),
    ('bal-0001-EUR', 'acc-0001', 'EUR', 25000000, 0),
    ('bal-0001-CAD', 'acc-0001', 'CAD', 10000000, 0),
    ('bal-0001-GBP', 'acc-0001', 'GBP', 8000000, 0),
    ('bal-0001-CHF', 'acc-0001', 'CHF', 6000000, 0),
    -- acc-0002
    ('bal-0002-PLN', 'acc-0002', 'PLN', 90000000, 0),
    ('bal-0002-USD', 'acc-0002', 'USD', 22000000, 0),
    ('bal-0002-EUR', 'acc-0002', 'EUR', 22000000, 0),
    ('bal-0002-CAD', 'acc-0002', 'CAD', 9000000, 0),
    ('bal-0002-GBP', 'acc-0002', 'GBP', 7000000, 0),
    ('bal-0002-CHF', 'acc-0002', 'CHF', 5000000, 0),
    -- acc-0003
    ('bal-0003-PLN', 'acc-0003', 'PLN', 85000000, 0),
    ('bal-0003-USD', 'acc-0003', 'USD', 20000000, 0),
    ('bal-0003-EUR', 'acc-0003', 'EUR', 20000000, 0),
    ('bal-0003-CAD', 'acc-0003', 'CAD', 8000000, 0),
    ('bal-0003-GBP', 'acc-0003', 'GBP', 6000000, 0),
    ('bal-0003-CHF', 'acc-0003', 'CHF', 4000000, 0),
    -- acc-0004
    ('bal-0004-PLN', 'acc-0004', 'PLN', 75000000, 0),
    ('bal-0004-USD', 'acc-0004', 'USD', 18000000, 0),
    ('bal-0004-EUR', 'acc-0004', 'EUR', 18000000, 0),
    ('bal-0004-CAD', 'acc-0004', 'CAD', 7000000, 0),
    ('bal-0004-GBP', 'acc-0004', 'GBP', 5000000, 0),
    ('bal-0004-CHF', 'acc-0004', 'CHF', 3000000, 0),
    -- acc-0005
    ('bal-0005-PLN', 'acc-0005', 'PLN', 95000000, 0),
    ('bal-0005-USD', 'acc-0005', 'USD', 21000000, 0),
    ('bal-0005-EUR', 'acc-0005', 'EUR', 21000000, 0),
    ('bal-0005-CAD', 'acc-0005', 'CAD', 9000000, 0),
    ('bal-0005-GBP', 'acc-0005', 'GBP', 7000000, 0),
    ('bal-0005-CHF', 'acc-0005', 'CHF', 5000000, 0),
    -- acc-0006
    ('bal-0006-PLN', 'acc-0006', 'PLN', 70000000, 0),
    ('bal-0006-USD', 'acc-0006', 'USD', 17000000, 0),
    ('bal-0006-EUR', 'acc-0006', 'EUR', 17000000, 0),
    ('bal-0006-CAD', 'acc-0006', 'CAD', 6000000, 0),
    ('bal-0006-GBP', 'acc-0006', 'GBP', 4000000, 0),
    ('bal-0006-CHF', 'acc-0006', 'CHF', 2000000, 0),
    -- acc-0007
    ('bal-0007-PLN', 'acc-0007', 'PLN', 80000000, 0),
    ('bal-0007-USD', 'acc-0007', 'USD', 19000000, 0),
    ('bal-0007-EUR', 'acc-0007', 'EUR', 19000000, 0),
    ('bal-0007-CAD', 'acc-0007', 'CAD', 7000000, 0),
    ('bal-0007-GBP', 'acc-0007', 'GBP', 5000000, 0),
    ('bal-0007-CHF', 'acc-0007', 'CHF', 3000000, 0),
    -- acc-0008
    ('bal-0008-PLN', 'acc-0008', 'PLN', 82000000, 0),
    ('bal-0008-USD', 'acc-0008', 'USD', 20000000, 0),
    ('bal-0008-EUR', 'acc-0008', 'EUR', 20000000, 0),
    ('bal-0008-CAD', 'acc-0008', 'CAD', 7000000, 0),
    ('bal-0008-GBP', 'acc-0008', 'GBP', 5000000, 0),
    ('bal-0008-CHF', 'acc-0008', 'CHF', 3000000, 0),
    -- acc-0009
    ('bal-0009-PLN', 'acc-0009', 'PLN', 90000000, 0),
    ('bal-0009-USD', 'acc-0009', 'USD', 22000000, 0),
    ('bal-0009-EUR', 'acc-0009', 'EUR', 22000000, 0),
    ('bal-0009-CAD', 'acc-0009', 'CAD', 8000000, 0),
    ('bal-0009-GBP', 'acc-0009', 'GBP', 6000000, 0),
    ('bal-0009-CHF', 'acc-0009', 'CHF', 4000000, 0),
    -- acc-0010
    ('bal-0010-PLN', 'acc-0010', 'PLN', 85000000, 0),
    ('bal-0010-USD', 'acc-0010', 'USD', 21000000, 0),
    ('bal-0010-EUR', 'acc-0010', 'EUR', 21000000, 0),
    ('bal-0010-CAD', 'acc-0010', 'CAD', 7000000, 0),
    ('bal-0010-GBP', 'acc-0010', 'GBP', 5000000, 0),
    ('bal-0010-CHF', 'acc-0010', 'CHF', 3000000, 0),
    -- acc-0011
    ('bal-0011-PLN', 'acc-0011', 'PLN', 75000000, 0),
    ('bal-0011-USD', 'acc-0011', 'USD', 18000000, 0),
    ('bal-0011-EUR', 'acc-0011', 'EUR', 18000000, 0),
    ('bal-0011-CAD', 'acc-0011', 'CAD', 6000000, 0),
    ('bal-0011-GBP', 'acc-0011', 'GBP', 4000000, 0),
    ('bal-0011-CHF', 'acc-0011', 'CHF', 2000000, 0),
    -- acc-0012
    ('bal-0012-PLN', 'acc-0012', 'PLN', 70000000, 0),
    ('bal-0012-USD', 'acc-0012', 'USD', 17000000, 0),
    ('bal-0012-EUR', 'acc-0012', 'EUR', 17000000, 0),
    ('bal-0012-CAD', 'acc-0012', 'CAD', 6000000, 0),
    ('bal-0012-GBP', 'acc-0012', 'GBP', 4000000, 0),
    ('bal-0012-CHF', 'acc-0012', 'CHF', 2000000, 0),
    -- acc-0013
    ('bal-0013-PLN', 'acc-0013', 'PLN', 95000000, 0),
    ('bal-0013-USD', 'acc-0013', 'USD', 23000000, 0),
    ('bal-0013-EUR', 'acc-0013', 'EUR', 23000000, 0),
    ('bal-0013-CAD', 'acc-0013', 'CAD', 9000000, 0),
    ('bal-0013-GBP', 'acc-0013', 'GBP', 7000000, 0),
    ('bal-0013-CHF', 'acc-0013', 'CHF', 5000000, 0),
    -- acc-0014
    ('bal-0014-PLN', 'acc-0014', 'PLN', 85000000, 0),
    ('bal-0014-USD', 'acc-0014', 'USD', 20000000, 0),
    ('bal-0014-EUR', 'acc-0014', 'EUR', 20000000, 0),
    ('bal-0014-CAD', 'acc-0014', 'CAD', 8000000, 0),
    ('bal-0014-GBP', 'acc-0014', 'GBP', 6000000, 0),
    ('bal-0014-CHF', 'acc-0014', 'CHF', 4000000, 0),
    -- acc-0015
    ('bal-0015-PLN', 'acc-0015', 'PLN', 90000000, 0),
    ('bal-0015-USD', 'acc-0015', 'USD', 22000000, 0),
    ('bal-0015-EUR', 'acc-0015', 'EUR', 22000000, 0),
    ('bal-0015-CAD', 'acc-0015', 'CAD', 8000000, 0),
    ('bal-0015-GBP', 'acc-0015', 'GBP', 6000000, 0),
    ('bal-0015-CHF', 'acc-0015', 'CHF', 4000000, 0),
    -- acc-0016
    ('bal-0016-PLN', 'acc-0016', 'PLN', 95000000, 0),
    ('bal-0016-USD', 'acc-0016', 'USD', 24000000, 0),
    ('bal-0016-EUR', 'acc-0016', 'EUR', 24000000, 0),
    ('bal-0016-CAD', 'acc-0016', 'CAD', 9000000, 0),
    ('bal-0016-GBP', 'acc-0016', 'GBP', 7000000, 0),
    ('bal-0016-CHF', 'acc-0016', 'CHF', 5000000, 0);

-- === Permissions ===
INSERT INTO accounts_permissions (account_permission_id, account_id, view_usage)
VALUES
    -- acc-0001
    ('perm-0001-T', 'acc-0001', 'TRANSFER_ACCOUNT'),
    ('perm-0001-C', 'acc-0001', 'CREDITED_ACCOUNT'),
    -- acc-0002
    ('perm-0002-T', 'acc-0002', 'TRANSFER_ACCOUNT'),
    ('perm-0002-C', 'acc-0002', 'CREDITED_ACCOUNT'),
    -- acc-0003
    ('perm-0003-T', 'acc-0003', 'TRANSFER_ACCOUNT'),
    ('perm-0003-C', 'acc-0003', 'CREDITED_ACCOUNT'),
    -- acc-0004
    ('perm-0004-T', 'acc-0004', 'TRANSFER_ACCOUNT'),
    ('perm-0004-C', 'acc-0004', 'CREDITED_ACCOUNT'),
    -- acc-0005
    ('perm-0005-T', 'acc-0005', 'TRANSFER_ACCOUNT'),
    ('perm-0005-C', 'acc-0005', 'CREDITED_ACCOUNT'),
    -- acc-0006
    ('perm-0006-T', 'acc-0006', 'TRANSFER_ACCOUNT'),
    ('perm-0006-C', 'acc-0006', 'CREDITED_ACCOUNT'),
    -- acc-0007
    ('perm-0007-T', 'acc-0007', 'TRANSFER_ACCOUNT'),
    ('perm-0007-C', 'acc-0007', 'CREDITED_ACCOUNT'),
    -- acc-0008
    ('perm-0008-T', 'acc-0008', 'TRANSFER_ACCOUNT'),
    ('perm-0008-C', 'acc-0008', 'CREDITED_ACCOUNT'),
    -- acc-0009
    ('perm-0009-T', 'acc-0009', 'TRANSFER_ACCOUNT'),
    ('perm-0009-C', 'acc-0009', 'CREDITED_ACCOUNT'),
    -- acc-0010
    ('perm-0010-T', 'acc-0010', 'TRANSFER_ACCOUNT'),
    ('perm-0010-C', 'acc-0010', 'CREDITED_ACCOUNT'),
    -- acc-0011
    ('perm-0011-T', 'acc-0011', 'TRANSFER_ACCOUNT'),
    ('perm-0011-C', 'acc-0011', 'CREDITED_ACCOUNT'),
    -- acc-0012
    ('perm-0012-T', 'acc-0012', 'TRANSFER_ACCOUNT'),
    ('perm-0012-C', 'acc-0012', 'CREDITED_ACCOUNT'),
    -- acc-0013
    ('perm-0013-T', 'acc-0013', 'TRANSFER_ACCOUNT'),
    ('perm-0013-C', 'acc-0013', 'CREDITED_ACCOUNT'),
    -- acc-0014
    ('perm-0014-T', 'acc-0014', 'TRANSFER_ACCOUNT'),
    ('perm-0014-C', 'acc-0014', 'CREDITED_ACCOUNT'),
    -- acc-0015
    ('perm-0015-T', 'acc-0015', 'TRANSFER_ACCOUNT'),
    ('perm-0015-C', 'acc-0015', 'CREDITED_ACCOUNT'),
    -- acc-0016
    ('perm-0016-T', 'acc-0016', 'TRANSFER_ACCOUNT'),
    ('perm-0016-C', 'acc-0016', 'CREDITED_ACCOUNT');

-- Link permissions to roles
INSERT INTO accounts_permissions_permissions (accounts_permissions_account_permission_id, permissions)
VALUES
    -- Admin/Accountant full access
    ('perm-0001-T', 'ADMIN'),
    ('perm-0001-T', 'ACCOUNTANT'),
    ('perm-0002-T', 'ADMIN'),
    ('perm-0002-T', 'ACCOUNTANT'),
    ('perm-0003-T', 'ADMIN'),
    ('perm-0003-T', 'ACCOUNTANT'),
    ('perm-0004-T', 'ADMIN'),
    ('perm-0004-T', 'ACCOUNTANT'),
    ('perm-0005-T', 'ADMIN'),
    ('perm-0005-T', 'ACCOUNTANT'),
    ('perm-0006-T', 'ADMIN'),
    ('perm-0006-T', 'ACCOUNTANT'),
    ('perm-0007-T', 'ADMIN'),
    ('perm-0007-T', 'ACCOUNTANT'),
    ('perm-0008-T', 'ADMIN'),
    ('perm-0008-T', 'ACCOUNTANT'),
    ('perm-0009-T', 'ADMIN'),
    ('perm-0009-T', 'ACCOUNTANT'),
    ('perm-0010-T', 'ADMIN'),
    ('perm-0010-T', 'ACCOUNTANT'),
    ('perm-0011-T', 'ADMIN'),
    ('perm-0011-T', 'ACCOUNTANT'),
    ('perm-0012-T', 'ADMIN'),
    ('perm-0012-T', 'ACCOUNTANT'),
    ('perm-0013-T', 'ADMIN'),
    ('perm-0013-T', 'ACCOUNTANT'),
    ('perm-0014-T', 'ADMIN'),
    ('perm-0014-T', 'ACCOUNTANT'),
    ('perm-0015-T', 'ADMIN'),
    ('perm-0015-T', 'ACCOUNTANT'),
    ('perm-0016-T', 'ADMIN'),
    ('perm-0016-T', 'ACCOUNTANT'),

    -- User credited accounts
    ('perm-0001-C', 'USER'),
    ('perm-0002-C', 'USER'),
    ('perm-0003-C', 'USER'),
    ('perm-0004-C', 'USER'),
    ('perm-0005-C', 'USER'),
    ('perm-0006-C', 'USER'),
    ('perm-0007-C', 'USER'),
    ('perm-0008-C', 'USER'),
    ('perm-0009-C', 'USER'),
    ('perm-0010-C', 'USER'),
    ('perm-0011-C', 'USER'),
    ('perm-0012-C', 'USER'),
    ('perm-0013-C', 'USER'),
    ('perm-0014-C', 'USER'),
    ('perm-0015-C', 'USER'),
    ('perm-0016-C', 'USER');

EOF

echo "✅ Database seeded!"