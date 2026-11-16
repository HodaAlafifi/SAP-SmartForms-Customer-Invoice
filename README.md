# Customer Invoice Using SAP Smart Forms

## Project Overview
This project generates a Customer Invoice using SAP ABAP and SAP Smart Forms.

It retrieves invoice header, customer, and item details from SAP database tables and displays them in a structured invoice layout.

## Technologies Used
- SAP ABAP
- SAP Smart Forms
- ABAP Dictionary (SE11)
- Internal Tables
- Function Modules
- SAP Database Tables

## Database Tables
| Table | Description |
|---|---|
| VBRK | Billing Document Header |
| VBRP | Billing Document Items |
| KNA1 | Customer Master Data |

## Project Structure

### 1. ABAP Driver Program
`ZSMARTFORM_INVOICE`

- Accepts an invoice number through a selection screen.
- Retrieves invoice header data from VBRK.
- Retrieves customer details from KNA1.
- Retrieves invoice items from VBRP.
- Calls the generated Smart Form Function Module.

### 2. Smart Form
`ZSF_CUSTOMER_INVOICE`

Displays:
- Invoice Header Information
- Customer Information
- Invoice Items Table

### 3. ABAP Dictionary Objects
| Object | Name | Description |
|---|---|---|
| Structure | ZSINVHEADER | Invoice Header Data |
| Structure | ZSINVCUSTOMER | Invoice Customer Details |
| Structure | ZSINVITEMS | Invoice Items |
| Table Type | ZTT_INV_ITEMS | Invoice Items Table |

## Project Output
The Smart Form generates a formatted Customer Invoice containing the invoice details and customer information.

![Customer Invoice](CUSTOMER%20INVOICE.png)

## Learning Outcomes
- Working with SAP database tables.
- Creating and using DDIC Structures and Table Types.
- Passing data through Smart Form interfaces.
- Using internal tables in Smart Forms.
- Calling generated Smart Form Function Modules dynamically.
