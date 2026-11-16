*&---------------------------------------------------------------------*
*& Report ZSMARTFORM_INVOICE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsmartform_invoice.


"DATABASE Tables declaration
TABLES: vbrk    "Billing Document Header
        ,vbrp   "	Billing Document Items
        ,kna1.  "Customer Master




"Internal tables&DATA Declaration
DATA:
  GS_VBRK TYPE ZSINVHEADER,
  GS_KNA1 TYPE ZSINVCUSTOMER,
  GT_VBRP TYPE ZTT_INV_ITEMS,
    LV_FM_NAME TYPE RS38L_FNAM.

"DESIGN SELECTION SCREEN
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001 .
  PARAMETERS: p_vbeln TYPE vbrk-vbeln OBLIGATORY.  "INVOICE NUMBER:
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.
  PERFORM Retrive_Invoice_Data .

CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
  EXPORTING
    FORMNAME = 'ZSF_CUSTOMER_INVOICE'
  IMPORTING
    FM_NAME  = LV_FM_NAME.

IF sy-subrc <> 0.
MESSAGE 'Smart Form Function Module not found' TYPE 'E'.
ENDIF.
CALL FUNCTION LV_FM_NAME
  EXPORTING
    IS_HEADER   = GS_VBRK
    IS_CUSTOMER = GS_KNA1
    IT_ITEMS    = GT_VBRP.
END-OF-SELECTION.
*&---------------------------------------------------------------------*
*& Form Retrive_Invoice_Data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM Retrive_Invoice_Data .
  " Get Invoice Header
  SELECT SINGLE vbeln fkdat kunag waerk netwr
    FROM vbrk
    INTO CORRESPONDING FIELDS OF gs_vbrk
  WHERE vbeln = p_vbeln.

  IF sy-subrc <> 0.
    MESSAGE 'Invoice not found' TYPE 'E'.
  ENDIF.

  " Get Customer Data
  SELECT SINGLE kunnr name1 ort01 land1
    FROM kna1
    INTO CORRESPONDING FIELDS OF gs_kna1
  WHERE kunnr = gs_vbrk-kunag.

  IF sy-subrc <> 0.
    MESSAGE 'Customer data not found' TYPE 'E'.
  ENDIF.

  " Get Invoice Items
  SELECT vbeln posnr matnr fkimg vrkme netwr
    FROM vbrp
    INTO CORRESPONDING FIELDS OF TABLE gt_vbrp
  WHERE vbeln = p_vbeln.

  IF sy-subrc <> 0.
    MESSAGE 'No invoice items found' TYPE 'E'.
  ENDIF.
ENDFORM.
