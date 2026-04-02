CLASS lhc_zr_mtok_t_task DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ZrMtokTTask
        RESULT result,
      setStatusDone FOR MODIFY
        IMPORTING keys FOR ACTION ZrMtokTTask~setStatusDone RESULT result,
      setStatusOpen FOR MODIFY
        IMPORTING keys FOR ACTION ZrMtokTTask~setStatusOpen RESULT result,
      setStatusWorking FOR MODIFY
        IMPORTING keys FOR ACTION ZrMtokTTask~setStatusWorking RESULT result,
      validateDescription FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrMtokTTask~validateDescription,
      calculateDefaultValues FOR DETERMINE ON MODIFY
        IMPORTING keys FOR ZrMtokTTask~calculateDefaultValues.
ENDCLASS.

CLASS lhc_zr_mtok_t_task IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD setStatusDone.
    " 1. Seçili kayıtları oku (EML kullanarak)
    READ ENTITIES OF zr_mtok_t_task IN LOCAL MODE
      ENTITY ZrMtokTTask
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_tasks).

    " 2. Statüleri güncelle
    MODIFY ENTITIES OF zr_mtok_t_task IN LOCAL MODE
      ENTITY ZrMtokTTask
      UPDATE FIELDS ( Status )
      WITH VALUE #( FOR task IN lt_tasks (
        %tky   = task-%tky
        Status = 'DONE' " Hedef statü
      ) )
      REPORTED DATA(lt_reported).

    " 3. Değişen veriyi arayüze geri gönder (Refresh için)
    READ ENTITIES OF zr_mtok_t_task IN LOCAL MODE
      ENTITY ZrMtokTTask
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_tasks_updated).

    result = VALUE #( FOR task_upd IN lt_tasks_updated (
        %tky   = task_upd-%tky
        %param = task_upd
    ) ).
  ENDMETHOD.

  METHOD setStatusOpen.
    " 1. Seçili kayıtları oku (EML kullanarak)
    READ ENTITIES OF zr_mtok_t_task IN LOCAL MODE
      ENTITY ZrMtokTTask
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_tasks).

    " 2. Statüleri güncelle
    MODIFY ENTITIES OF zr_mtok_t_task IN LOCAL MODE
      ENTITY ZrMtokTTask
      UPDATE FIELDS ( Status )
      WITH VALUE #( FOR task IN lt_tasks (
        %tky   = task-%tky
        Status = 'OPEN' " Hedef statü
      ) )
      REPORTED DATA(lt_reported).

    " 3. Değişen veriyi arayüze geri gönder (Refresh için)
    READ ENTITIES OF zr_mtok_t_task IN LOCAL MODE
      ENTITY ZrMtokTTask
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_tasks_updated).

    result = VALUE #( FOR task_upd IN lt_tasks_updated (
        %tky   = task_upd-%tky
        %param = task_upd
    ) ).
  ENDMETHOD.

  METHOD setStatusWorking.
    " 1. Seçili kayıtları oku (EML kullanarak)
    READ ENTITIES OF zr_mtok_t_task IN LOCAL MODE
      ENTITY ZrMtokTTask
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_tasks).

    " 2. Statüleri güncelle
    MODIFY ENTITIES OF zr_mtok_t_task IN LOCAL MODE
      ENTITY ZrMtokTTask
      UPDATE FIELDS ( Status )
      WITH VALUE #( FOR task IN lt_tasks (
        %tky   = task-%tky
        Status = 'WORKING' " Hedef statü
      ) )
      REPORTED DATA(lt_reported).

    " 3. Değişen veriyi arayüze geri gönder (Refresh için)
    READ ENTITIES OF zr_mtok_t_task IN LOCAL MODE
      ENTITY ZrMtokTTask
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_tasks_updated).

    result = VALUE #( FOR task_upd IN lt_tasks_updated (
        %tky   = task_upd-%tky
        %param = task_upd
    ) ).
  ENDMETHOD.

  METHOD validateDescription.
    " 1. Taslak (Draft) veya asıl veriyi oku
    READ ENTITIES OF zr_mtok_t_task IN LOCAL MODE
      ENTITY ZrMtokTTask
      FIELDS ( Description ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_tasks).

    LOOP AT lt_tasks INTO DATA(ls_task).
      " 2. Kural: Açıklama boş mu?
      IF ls_task-Description IS INITIAL.

        " 3. Başarısız olan anahtarı 'failed' tablosuna ekle (Kaydı durdurur)
        APPEND VALUE #( %tky = ls_task-%tky ) TO failed-zrmtokttask.

        " 4. Ekrana hata mesajını 'reported' tablosuyla gönder
        APPEND VALUE #( %tky = ls_task-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'Açıklama alanı boş bırakılamaz!' )
                        %element-Description = if_abap_behv=>mk-on "Hata hangi alanda?
                      ) TO reported-zrmtokttask.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD calculateDefaultValues.

    " 1. Henüz kaydedilmemiş (Draft) kayıtları oku
    READ ENTITIES OF zr_mtok_t_task IN LOCAL MODE
      ENTITY ZrMtokTTask
      FIELDS ( Status ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_tasks).

    " 2. Sadece statüsü boş olanları filtrele (Önceden dolmuşsa ezmemek için)
    DELETE lt_tasks WHERE Status IS NOT INITIAL.
    IF lt_tasks IS INITIAL. RETURN. ENDIF.

    " 3. Statüyü 'OPEN' olarak güncelle
    MODIFY ENTITIES OF zr_mtok_t_task IN LOCAL MODE
      ENTITY ZrMtokTTask
      UPDATE FIELDS ( Status )
      WITH VALUE #( FOR task IN lt_tasks (
        %tky   = task-%tky
        Status = 'OPEN'
      ) )
      REPORTED DATA(lt_reported).
    reported = CORRESPONDING #( DEEP lt_reported ).

  ENDMETHOD.

ENDCLASS.
