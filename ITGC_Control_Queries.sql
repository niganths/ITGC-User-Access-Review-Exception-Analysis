use itgc_review

-- c01 start
SELECT
    u.User_ID,
    u.Emp_ID_FK,
    e.Employee_Name,
    e.Department,
    e.Employment_Status,
    u.System,
    u.Account_Status
FROM user_accounts u
JOIN employee_master e
    ON u.Emp_ID_FK = e.Emp_ID
WHERE e.Employment_Status = 'Terminated'
  AND u.Account_Status = 'Active';
  
  SELECT
   count(*) as exceptions
FROM user_accounts u
JOIN employee_master e
    ON u.Emp_ID_FK = e.Emp_ID
WHERE e.Employment_Status = 'Terminated'
  AND u.Account_Status = 'Active';
  
-- c01 end 

-- c02 start

select * from role_assignments
 
SELECT
    r.Assignment_ID,
    r.User_ID,
    r.Emp_ID,
    r.Role,
    r.System,
    r.Privilege_Level,
    r.Approval_Status
FROM role_assignments r
WHERE r.Privilege_Level = 'Privileged'
  AND r.Approval_Status <> 'Approved';
  
SELECT count(*)
FROM role_assignments r
WHERE r.Privilege_Level = 'Privileged'
AND r.Approval_Status <> 'Approved';

SELECT distinct count(distinct User_ID)
FROM role_assignments r
WHERE r.Privilege_Level = 'Privileged'
AND r.Approval_Status <> 'Approved';

-- c02 end

-- c03 start
select * from access_matrix

SELECT
    r.Assignment_ID,
    r.User_ID,
    r.Emp_ID,
    e.Employee_Name,
    e.Job_Title,
    r.Role,
    r.System,
    r.Privilege_Level
FROM role_assignments r
JOIN employee_master e
    ON r.Emp_ID = e.Emp_ID
LEFT JOIN access_matrix a
    ON e.Job_Title = a.Job_Title
    AND r.Role = a.Permitted_Role
WHERE a.Permitted_Role IS NULL;

SELECT
   count(*)
FROM role_assignments r
JOIN employee_master e
    ON r.Emp_ID = e.Emp_ID
LEFT JOIN access_matrix a
    ON e.Job_Title = a.Job_Title
    AND r.Role = a.Permitted_Role
WHERE a.Permitted_Role IS NULL;

SELECT
   count(distinct r.User_ID)
FROM role_assignments r
JOIN employee_master e
    ON r.Emp_ID = e.Emp_ID
LEFT JOIN access_matrix a
    ON e.Job_Title = a.Job_Title
    AND r.Role = a.Permitted_Role
WHERE a.Permitted_Role IS NULL;

-- c03 end

-- c04 start

select * from sod_rules

SELECT DISTINCT
    r1.User_ID,
    r1.Emp_ID,
    e.Employee_Name,
    e.Department,
    r1.Role AS Role_1,
    r2.Role AS Role_2,
    s.Conflict_ID,
    s.Domain,
    s.Risk,
    s.Control_Objective
FROM role_assignments r1
JOIN role_assignments r2
    ON r1.User_ID = r2.User_ID
    AND r1.Assignment_ID <> r2.Assignment_ID
JOIN employee_master e
    ON r1.Emp_ID = e.Emp_ID
JOIN sod_rules s
    ON (
        (r1.Role = s.Role_A AND r2.Role = s.Role_B)
        OR
        (r1.Role = s.Role_B AND r2.Role = s.Role_A)
    )
ORDER BY r1.User_ID, s.Conflict_ID;

SELECT COUNT(DISTINCT CONCAT(r1.User_ID, '|', s.Conflict_ID)) AS C04_SOD_Exceptions
FROM role_assignments r1
JOIN role_assignments r2
    ON r1.User_ID = r2.User_ID
    AND r1.Assignment_ID <> r2.Assignment_ID
JOIN sod_rules s
    ON (
        (r1.Role = s.Role_A AND r2.Role = s.Role_B)
        OR
        (r1.Role = s.Role_B AND r2.Role = s.Role_A)
    );
    
SELECT COUNT(DISTINCT r1.User_ID) AS C04_Affected_Users
FROM role_assignments r1
JOIN role_assignments r2
    ON r1.User_ID = r2.User_ID
    AND r1.Assignment_ID <> r2.Assignment_ID
JOIN sod_rules s
    ON (
        (r1.Role = s.Role_A AND r2.Role = s.Role_B)
        OR
        (r1.Role = s.Role_B AND r2.Role = s.Role_A)
    );
    
-- c04 end 

-- c05 start
SELECT
    COUNT(DISTINCT User_ID) AS C05_Affected_Users
FROM user_accounts
WHERE Password_Last_Changed < DATE_SUB('2026-10-14', INTERVAL 90 DAY)
   OR MFA_Enabled = 'No';

SELECT
    COUNT(DISTINCT CASE
        WHEN Password_Last_Changed < DATE_SUB('2026-10-14', INTERVAL 90 DAY)
        THEN User_ID
    END) AS Password_Exceptions,

    COUNT(DISTINCT CASE
        WHEN MFA_Enabled = 'No'
        THEN User_ID
    END) AS MFA_Not_Enabled,

    COUNT(DISTINCT CASE
        WHEN Password_Last_Changed < DATE_SUB('2026-10-14', INTERVAL 90 DAY)
          OR MFA_Enabled = 'No'
        THEN User_ID
    END) AS C05_Affected_Users
FROM user_accounts;

SELECT DISTINCT
    User_ID,
    Account_Name,
    MFA_Enabled,
    Password_Last_Changed
FROM user_accounts
WHERE Password_Last_Changed < DATE_SUB('2026-10-14', INTERVAL 90 DAY)
   OR MFA_Enabled = 'No'
ORDER BY User_ID;


-- c05 end