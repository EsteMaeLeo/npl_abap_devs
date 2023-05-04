*&---------------------------------------------------------------------*
*& Report ZPG_PERSON_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpg_person_001.

SELECTION-SCREEN BEGIN OF BLOCK block1 WITH FRAME TITLE TEXT-t04.
PARAMETERS:  p_id TYPE zidcr.
SELECTION-SCREEN END OF BLOCK block1.

START-OF-SELECTION.

  DATA: gwa_person  TYPE  zstperson,
        gwa_message TYPE  bapiret2.

  SELECT SINGLE rfcdest
      FROM rfcdes
      WHERE rfcdest = 'ER1'
      INTO @DATA(sap_system).

  CALL FUNCTION 'RFC_PING' DESTINATION sap_system
    EXCEPTIONS
      OTHERS = 1.

  IF sy-subrc EQ 0.
    CALL FUNCTION 'ZFM_PERSON_READ_PERSON'
      DESTINATION sap_system
      EXPORTING
        im_id      = p_id
      IMPORTING
        ex_person  = gwa_person
        ex_message = gwa_message.

    IF sy-subrc EQ 0.
      WRITE: / 'ID : ', gwa_person-id, gwa_person-name, gwa_person-first_last_name.
    ENDIF.

  ENDIF.
  ULINE.
