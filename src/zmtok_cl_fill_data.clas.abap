CLASS zmtok_cl_fill_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmtok_cl_fill_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DELETE FROM zmtok_t_task.
  ENDMETHOD.
ENDCLASS.
