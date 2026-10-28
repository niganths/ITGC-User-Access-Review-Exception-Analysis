ITGC User Access Review

A self-initiated project to understand how ITGC user access reviews are performed using SQL, Excel and Power BI.

I created a synthetic dataset and used it to test common access-control scenarios that can come up during an IT audit.

What I worked on

The project covers five main controls:

C01 – Terminated User Access

C02 – Privileged Access Approval

C03 – Role / Job Alignment

C04 – Segregation of Duties (SoD)

C05 – Password & MFA Compliance

The data contains:

200 employees

260 user accounts

450 role assignments

12 SoD rules

45 access-matrix rules

All data used in this project is synthetic.

How I did it

I started by creating the employee, account, role and control-rule datasets.

Then I used SQL to test the controls and identify exceptions.

The main checks included:

Terminated employee → Active account

Privileged role → Approval required

Job Title + Role + System → Must exist in Access Matrix

Conflicting roles → SoD exception

Password > 90 days → Exception

MFA = No → Exception

The identified exceptions were then documented in an Excel exception register along with comments, ownership, remediation status and evidence references.

Finally, I created a Power BI dashboard to give a quick view of the overall access-control review.

Results

The SQL testing identified 128 exception instances.

Control

Exceptions

Affected Users

C01 – Terminated User Access

6

6

C02 – Privileged Access Approval

14

13

C03 – Role / Job Alignment

46

46

C04 – Segregation of Duties

30

19

C05 – Password / MFA

32

32

Other findings:

82 high-risk exceptions

26 MFA exceptions

6 password-age exceptions

C03 had the highest number of exceptions

Power BI Dashboard

The dashboard focuses on the main things I would want to see during an access review:

Total employees

Total accounts

Total role assignments

Total exceptions

High-risk exceptions

Exceptions by control

Risk distribution

Account status

MFA and password exceptions

Tools Used

SQL – Control testing and exception identification
Excel – Exception register and audit documentation
Power BI – Dashboard and reporting
DAX – Measures and KPIs

Project Structure

ITGC-User-Access-Review
│
├── data
│   └── Synthetic_Data.xlsx
│
├── sql
│   └── ITGC_Control_Tests.sql
│
├── excel
│   └── ITGC_Exception_Register.xlsx
│
├── powerbi
│   └── ITGC_Access_Control_Dashboard.pbix
│
└── README.md

What I learned

This project helped me understand the practical side of:

ITGC access reviews

Control testing

Access-risk identification

Segregation of Duties

Exception documentation

Audit evidence

SQL-based audit analysis

Power BI reporting

Note

This is a self-initiated portfolio project created for learning and interview purposes. The dataset is completely synthetic and does not contain real employee or company information.

Niganth SG
MBA – Finance & Business Analytics
