CLASS lhc_zr_mtok_t_task DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ZrMtokTTask
        RESULT result.
ENDCLASS.

CLASS lhc_zr_mtok_t_task IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
ENDCLASS.
