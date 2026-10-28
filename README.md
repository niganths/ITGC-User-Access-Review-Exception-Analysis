# ITGC User Access Review

A self-initiated project to understand how ITGC user access reviews are performed using **SQL, Excel and Power BI**.

The project uses synthetic employee and access data to test common ITGC access controls and document exceptions.

## Controls Tested

| Control | Check |
|---|---|
| C01 | Terminated user with active access |
| C02 | Privileged access without approval |
| C03 | Role not aligned with job |
| C04 | Segregation of Duties (SoD) conflict |
| C05 | Password & MFA compliance |

## Data

- 200 Employees
- 260 User Accounts
- 450 Role Assignments
- 12 SoD Rules
- 45 Access Matrix Rules
- Synthetic data only

## SQL Checks

The main SQL checks were:

- Terminated employee → Active account
- Privileged role → Approval required
- Job + Role + System → Valid access matrix entry
- Conflicting roles → SoD exception
- Password age > 90 days → Exception
- MFA = No → Exception

## Results

**128 exception instances identified**

| Control | Exceptions | Affected Users |
|---|---:|---:|
| C01 | 6 | 6 |
| C02 | 14 | 13 |
| C03 | 46 | 46 |
| C04 | 30 | 19 |
| C05 | 32 | 32 |

**Additional findings**
- 82 high-risk exceptions
- 26 MFA exceptions
- 6 password-age exceptions
- C03 had the highest number of exceptions

## Exception Register

Exceptions were documented in Excel with:

- Exception ID
- Control
- Risk / Priority
- Owner
- Status
- Management Response
- Target Date
- Evidence Reference

## Power BI Dashboard

The dashboard covers:

- Total employees and accounts
- Total exceptions
- High-risk exceptions
- Exceptions by control
- Risk distribution
- MFA and password exceptions
- Account status

## Tools

**SQL · Excel · Power BI · DAX**

## Project Structure

```text
ITGC-User-Access-Review/
│
├── data/
│   └── Synthetic_Data.xlsx
│
├── sql/
│   └── ITGC_Control_Tests.sql
│
├── excel/
│   └── ITGC_Exception_Register.xlsx
│
├── powerbi/
│   └── ITGC_Access_Control_Dashboard.pbix
│
└── README.md
```

## What I Learned

- ITGC access review
- Control testing
- Access-risk identification
- Segregation of Duties
- Exception documentation
- Audit evidence
- SQL-based control testing
- Power BI reporting

## Note

This is a self-initiated portfolio project created for learning and interview preparation. All data is synthetic.
