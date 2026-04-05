import 'package:flutter/material.dart';
import 'package:login_ora/core/config/language_service.dart';
// ignore: unused_import
import 'package:login_ora/main.dart';
import 'package:login_ora/presentation/screens/tab_lezioni/lezioni_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _bioController = TextEditingController();
  final _nationalityController = TextEditingController();
  final LanguageService _languageService = LanguageService(); // NUOVO

  String _selectedLanguage = 'it';
  DateTime? _birthDate;
  String? _avatarUrl;
  File? _imageFile;
  bool _isLoading = false;
  String? _lastUpdated;

  // Mappa lingue con bandiere e traduzioni
  final Map<String, Map<String, dynamic>> _languages = {
    'en': {
      'name': 'English',
      'flag': '🇬🇧',
      'translations': {
        'title': 'Edit Profile',
        'email': 'Email',
        'name': 'Name',
        'displayName': 'Display Name',
        'nationality': 'Nationality',
        'birthDate': 'Birth Date',
        'language': 'Preferred Language',
        'bio': 'Bio',
        'save': 'SAVE CHANGES',
        'lastUpdate': 'Last update',
        'tapToChange': 'Tap to change',
        'enterName': 'Enter your name',
        'publicName': 'Public name (optional)',
        'exNationality': 'E.g. Italian',
        'selectBirthDate': 'Select birth date',
        'selectLanguage': 'Select Language',
        'tellAboutYou': 'Tell something about yourself...',
        'successMessage': '✅ Profile updated successfully!',
        'updated': 'Updated',
      },
    },
    'it': {
      'name': 'Italiano',
      'flag': '🇮🇹',
      'translations': {
        'title': 'Modifica Profilo',
        'email': 'Email',
        'name': 'Nome',
        'displayName': 'Nome visualizzato',
        'nationality': 'Nazionalità',
        'birthDate': 'Data di nascita',
        'language': 'Lingua preferita',
        'bio': 'Bio',
        'save': 'SALVA MODIFICHE',
        'lastUpdate': 'Ultimo aggiornamento',
        'tapToChange': 'Tocca per cambiare',
        'enterName': 'Inserisci il tuo nome',
        'publicName': 'Nome pubblico (opzionale)',
        'exNationality': 'Es: Italiana',
        'selectBirthDate': 'Seleziona data di nascita',
        'selectLanguage': 'Seleziona Lingua',
        'tellAboutYou': 'Racconta qualcosa di te...',
        'successMessage': '✅ Profilo aggiornato con successo!',
        'updated': 'Aggiornato',
      },
    },
    'de': {
      'name': 'Deutsch',
      'flag': '🇩🇪',
      'translations': {
        'title': 'Profil bearbeiten',
        'email': 'E-Mail',
        'name': 'Name',
        'displayName': 'Anzeigename',
        'nationality': 'Nationalität',
        'birthDate': 'Geburtsdatum',
        'language': 'Bevorzugte Sprache',
        'bio': 'Bio',
        'save': 'ÄNDERUNGEN SPEICHERN',
        'lastUpdate': 'Letzte Aktualisierung',
        'tapToChange': 'Tippen zum Ändern',
        'enterName': 'Geben Sie Ihren Namen ein',
        'publicName': 'Öffentlicher Name (optional)',
        'exNationality': 'Z.B. Deutsch',
        'selectBirthDate': 'Geburtsdatum auswählen',
        'selectLanguage': 'Sprache wählen',
        'tellAboutYou': 'Erzählen Sie etwas über sich...',
        'successMessage': '✅ Profil erfolgreich aktualisiert!',
        'updated': 'Aktualisiert',
      },
    },
    'es': {
      'name': 'Español',
      'flag': '🇪🇸',
      'translations': {
        'title': 'Editar Perfil',
        'email': 'Correo electrónico',
        'name': 'Nombre',
        'displayName': 'Nombre para mostrar',
        'nationality': 'Nacionalidad',
        'birthDate': 'Fecha de nacimiento',
        'language': 'Idioma preferido',
        'bio': 'Biografía',
        'save': 'GUARDAR CAMBIOS',
        'lastUpdate': 'Última actualización',
        'tapToChange': 'Toca para cambiar',
        'enterName': 'Ingresa tu nombre',
        'publicName': 'Nombre público (opcional)',
        'exNationality': 'Ej: Española',
        'selectBirthDate': 'Seleccionar fecha de nacimiento',
        'selectLanguage': 'Seleccionar idioma',
        'tellAboutYou': 'Cuéntanos algo sobre ti...',
        'successMessage': '¡Perfil actualizado con éxito!',
        'updated': 'Actualizado',
      },
    },
    'fr': {
      'name': 'Français',
      'flag': '🇫🇷',
      'translations': {
        'title': 'Modifier le profil',
        'email': 'E-mail',
        'name': 'Nom',
        'displayName': 'Nom affiché',
        'nationality': 'Nationalité',
        'birthDate': 'Date de naissance',
        'language': 'Langue préférée',
        'bio': 'Bio',
        'save': 'ENREGISTRER',
        'lastUpdate': 'Dernière mise à jour',
        'tapToChange': 'Appuyez pour modifier',
        'enterName': 'Entrez votre nom',
        'publicName': 'Nom public (optionnel)',
        'exNationality': 'Ex: Française',
        'selectBirthDate': 'Sélectionner la date',
        'selectLanguage': 'Sélectionner la langue',
        'tellAboutYou': 'Parlez-nous de vous...',
        'successMessage': '✅ Profil mis à jour!',
        'updated': 'Mis à jour',
      },
    },
    'ru': {
      'name': 'Русский',
      'flag': '🇷🇺',
      'translations': {
        'title': 'Редактировать профиль',
        'email': 'Электронная почта',
        'name': 'Имя',
        'displayName': 'Отображаемое имя',
        'nationality': 'Национальность',
        'birthDate': 'Дата рождения',
        'language': 'Предпочитаемый язык',
        'bio': 'Биография',
        'save': 'СОХРАНИТЬ ИЗМЕНЕНИЯ',
        'lastUpdate': 'Последнее обновление',
        'tapToChange': 'Нажмите, чтобы изменить',
        'enterName': 'Введите ваше имя',
        'publicName': 'Публичное имя (необязательно)',
        'exNationality': 'Напр.: Русский',
        'selectBirthDate': 'Выберите дату рождения',
        'selectLanguage': 'Выберите язык',
        'tellAboutYou': 'Расскажите что-нибудь о себе...',
        'successMessage': '✅ Профиль успешно обновлен!',
        'updated': 'Обновлено',
      },
    },

    'zh': {
      'name': '中文',
      'flag': '🇨🇳',
      'translations': {
        'title': '编辑个人资料',
        'email': '电子邮件',
        'name': '姓名',
        'displayName': '显示名称',
        'nationality': '国籍',
        'birthDate': '出生日期',
        'language': '首选语言',
        'bio': '简介',
        'save': '保存更改',
        'lastUpdate': '最后更新',
        'tapToChange': '点击更改',
        'enterName': '输入您的姓名',
        'publicName': '公开名称（可选）',
        'exNationality': '例如：中国',
        'selectBirthDate': '选择出生日期',
        'selectLanguage': '选择语言',
        'tellAboutYou': '告诉我们一些关于你自己的事...',
        'successMessage': '✅ 个人资料更新成功！',
        'updated': '已更新',
      },
    },

    'bg': {
      'name': 'Български',
      'flag': '🇧🇬',
      'translations': {
        'title': 'Редактиране на профил',
        'email': 'Имейл',
        'name': 'Име',
        'displayName': 'Публично име',
        'nationality': 'Националност',
        'birthDate': 'Дата на раждане',
        'language': 'Предпочитан език',
        'bio': 'Биография',
        'save': 'ЗАПАЗИ ПРОМЕНИТЕ',
        'lastUpdate': 'Последна актуализация',
        'tapToChange': 'Докоснете, за да промените',
        'enterName': 'Въведете вашето име',
        'publicName': 'Публично име (по избор)',
        'exNationality': 'Напр.: Българин',
        'selectBirthDate': 'Изберете дата на раждане',
        'selectLanguage': 'Изберете език',
        'tellAboutYou': 'Разкажете нещо за себе си...',
        'successMessage': '✅ Профилът е успешно актуализиран!',
        'updated': 'Актуализирано',
      },
    },

    'cs': {
      'name': 'Čeština',
      'flag': '🇨🇿',
      'translations': {
        'title': 'Upravit profil',
        'email': 'E-mail',
        'name': 'Jméno',
        'displayName': 'Zobrazované jméno',
        'nationality': 'Národnost',
        'birthDate': 'Datum narození',
        'language': 'Preferovaný jazyk',
        'bio': 'Bio',
        'save': 'ULOŽIT ZMĚNY',
        'lastUpdate': 'Poslední aktualizace',
        'tapToChange': 'Klepněte pro změnu',
        'enterName': 'Zadejte své jméno',
        'publicName': 'Veřejné jméno (volitelné)',
        'exNationality': 'Např.: Čech',
        'selectBirthDate': 'Vyberte datum narození',
        'selectLanguage': 'Vyberte jazyk',
        'tellAboutYou': 'Řekněte nám něco o sobě...',
        'successMessage': '✅ Profil byl úspěšně aktualizován!',
        'updated': 'Aktualizováno',
      },
    },

    'da': {
      'name': 'Dansk',
      'flag': '🇩🇰',
      'translations': {
        'title': 'Rediger profil',
        'email': 'E-mail',
        'name': 'Navn',
        'displayName': 'Visningsnavn',
        'nationality': 'Nationalitet',
        'birthDate': 'Fødselsdato',
        'language': 'Foretrukket sprog',
        'bio': 'Bio',
        'save': 'GEM ÆNDRINGER',
        'lastUpdate': 'Sidste opdatering',
        'tapToChange': 'Tryk for at ændre',
        'enterName': 'Indtast dit navn',
        'publicName': 'Offentligt navn (valgfrit)',
        'exNationality': 'F.eks.: Dansk',
        'selectBirthDate': 'Vælg fødselsdato',
        'selectLanguage': 'Vælg sprog',
        'tellAboutYou': 'Fortæl os noget om dig selv...',
        'successMessage': '✅ Profil opdateret succesfuldt!',
        'updated': 'Opdateret',
      },
    },

    'et': {
      'name': 'Eesti',
      'flag': '🇪🇪',
      'translations': {
        'title': 'Redigeeri profiili',
        'email': 'E-post',
        'name': 'Nimi',
        'displayName': 'Kuvatav nimi',
        'nationality': 'Rahvus',
        'birthDate': 'Sünnikuupäev',
        'language': 'Eelistatud keel',
        'bio': 'Bio',
        'save': 'SALVESTA MUUDATUSI',
        'lastUpdate': 'Viimane uuendus',
        'tapToChange': 'Puuduta, et muuta',
        'enterName': 'Sisesta oma nimi',
        'publicName': 'Avalik nimi (valikuline)',
        'exNationality': 'Nt: Eesti',
        'selectBirthDate': 'Vali sünnikuupäev',
        'selectLanguage': 'Vali keel',
        'tellAboutYou': 'Räägi meile midagi enda kohta...',
        'successMessage': '✅ Profiil on edukalt uuendatud!',
        'updated': 'Uuendatud',
      },
    },

    'fi': {
      'name': 'Suomi',
      'flag': '🇫🇮',
      'translations': {
        'title': 'Muokkaa profiilia',
        'email': 'Sähköposti',
        'name': 'Nimi',
        'displayName': 'Näkyvä nimi',
        'nationality': 'Kansalaisuus',
        'birthDate': 'Syntymäaika',
        'language': 'Ensisijainen kieli',
        'bio': 'Bio',
        'save': 'TALLENNA MUUTOKSET',
        'lastUpdate': 'Viimeisin päivitys',
        'tapToChange': 'Napauta vaihtaaksesi',
        'enterName': 'Syötä nimesi',
        'publicName': 'Julkinen nimi (valinnainen)',
        'exNationality': 'Esim.: Suomalainen',
        'selectBirthDate': 'Valitse syntymäaika',
        'selectLanguage': 'Valitse kieli',
        'tellAboutYou': 'Kerro jotain itsestäsi...',
        'successMessage': '✅ Profiili päivitetty onnistuneesti!',
        'updated': 'Päivitetty',
      },
    },

    'el': {
      'name': 'Ελληνικά',
      'flag': '🇬🇷',
      'translations': {
        'title': 'Επεξεργασία Προφίλ',
        'email': 'Email',
        'name': 'Όνομα',
        'displayName': 'Εμφανιζόμενο Όνομα',
        'nationality': 'Εθνικότητα',
        'birthDate': 'Ημερομηνία Γέννησης',
        'language': 'Προτιμώμενη Γλώσσα',
        'bio': 'Βιογραφικό',
        'save': 'ΑΠΟΘΗΚΕΥΣΗ ΑΛΛΑΓΩΝ',
        'lastUpdate': 'Τελευταία ενημέρωση',
        'tapToChange': 'Πατήστε για αλλαγή',
        'enterName': 'Εισάγετε το όνομά σας',
        'publicName': 'Δημόσιο όνομα (προαιρετικό)',
        'exNationality': 'π.χ. Έλληνας',
        'selectBirthDate': 'Επιλέξτε ημερομηνία γέννησης',
        'selectLanguage': 'Επιλέξτε γλώσσα',
        'tellAboutYou': 'Πείτε μας κάτι για εσάς...',
        'successMessage': '✅ Το προφίλ ενημερώθηκε με επιτυχία!',
        'updated': 'Ενημερώθηκε',
      },
    },

    'ga': {
      'name': 'Gaeilge',
      'flag': '🇮🇪',
      'translations': {
        'title': 'Cuir Próifíl in Eagar',
        'email': 'Ríomhphost',
        'name': 'Ainm',
        'displayName': 'Ainm Taispeána',
        'nationality': 'Náisiúntacht',
        'birthDate': 'Dáta Breithe',
        'language': 'Teanga Réamhshocraithe',
        'bio': 'Beathaisnéis',
        'save': 'SÁCHAILT ATHRÚ',
        'lastUpdate': 'Nuashonrú Deireanach',
        'tapToChange': 'Tapáil chun athrú',
        'enterName': 'Cuir isteach d\'ainm',
        'publicName': 'Ainm Poiblí (roghnach)',
        'exNationality': 'M.sh.: Éireannach',
        'selectBirthDate': 'Roghnaigh dáta breithe',
        'selectLanguage': 'Roghnaigh Teanga',
        'tellAboutYou': 'Inis dúinn rud éigin fút féin...',
        'successMessage': '✅ Nuashonraíodh an próifíl go rathúil!',
        'updated': 'Nuashonraithe',
      },
    },

    'lv': {
      'name': 'Latviešu',
      'flag': '🇱🇻',
      'translations': {
        'title': 'Rediģēt profilu',
        'email': 'E-pasts',
        'name': 'Vārds',
        'displayName': 'Rādāmais vārds',
        'nationality': 'Nacionālība',
        'birthDate': 'Dzimšanas datums',
        'language': 'Vēlamā valoda',
        'bio': 'Bio',
        'save': 'SAGLABĀT IZMAIŅAS',
        'lastUpdate': 'Pēdējā atjaunināšana',
        'tapToChange': 'Pieskarieties, lai mainītu',
        'enterName': 'Ievadiet savu vārdu',
        'publicName': 'Publiskais vārds (pēc izvēles)',
        'exNationality': 'Piemēram: Latvijas',
        'selectBirthDate': 'Izvēlieties dzimšanas datumu',
        'selectLanguage': 'Izvēlieties valodu',
        'tellAboutYou': 'Pastāstiet mums kaut ko par sevi...',
        'successMessage': '✅ Profils veiksmīgi atjaunināts!',
        'updated': 'Atjaunināts',
      },
    },

    'lt': {
      'name': 'Lietuvių',
      'flag': '🇱🇹',
      'translations': {
        'title': 'Redaguoti profilį',
        'email': 'El. paštas',
        'name': 'Vardas',
        'displayName': 'Rodyti vardą',
        'nationality': 'Tautybė',
        'birthDate': 'Gimimo data',
        'language': 'Pageidaujama kalba',
        'bio': 'Apie mane',
        'save': 'IŠSAUGOTI PAKEITIMUS',
        'lastUpdate': 'Paskutinis atnaujinimas',
        'tapToChange': 'Bakstelėkite, kad pakeistumėte',
        'enterName': 'Įveskite savo vardą',
        'publicName': 'Viešas vardas (pasirinktinai)',
        'exNationality': 'Pvz.: Lietuvis',
        'selectBirthDate': 'Pasirinkite gimimo datą',
        'selectLanguage': 'Pasirinkite kalbą',
        'tellAboutYou': 'Papaskite ką nors apie save...',
        'successMessage': '✅ Profilis sėkmingai atnaujintas!',
        'updated': 'Atnaujinta',
      },
    },

    'mt': {
      'name': 'Malti',
      'flag': '🇲🇹',
      'translations': {
        'title': 'Editja l-Profil',
        'email': 'Email',
        'name': 'Isem',
        'displayName': 'Isem Mibgħut',
        'nationality': 'Nazzjonalità',
        'birthDate': 'Data tat-Twelid',
        'language': 'Lingwa Preferuta',
        'bio': 'Bio',
        'save': 'ISAĦĦAR BIDLA',
        'lastUpdate': 'L-aħħar aġġornament',
        'tapToChange': 'Ikklikkja biex tibdel',
        'enterName': 'Daħħal l-isem tiegħek',
        'publicName': 'Isem Pubbliku (għażil)',
        'exNationality': 'Eż.: Malti',
        'selectBirthDate': 'Agħżel data tat-twelid',
        'selectLanguage': 'Agħżel Lingwa',
        'tellAboutYou': 'Għidilna xi ħaġa għalik...',
        'successMessage': '✅ Il-profil ġie aġġornat b\'suċċess!',
        'updated': 'Aġġornat',
      },
    },

    'pl': {
      'name': 'Polski',
      'flag': '🇵🇱',
      'translations': {
        'title': 'Edytuj profil',
        'email': 'E-mail',
        'name': 'Imię',
        'displayName': 'Nazwa wyświetlana',
        'nationality': 'Narodowość',
        'birthDate': 'Data urodzenia',
        'language': 'Preferowany język',
        'bio': 'Bio',
        'save': 'ZAPISZ ZMIANY',
        'lastUpdate': 'Ostatnia aktualizacja',
        'tapToChange': 'Stuknij, aby zmienić',
        'enterName': 'Wprowadź swoje imię',
        'publicName': 'Nazwa publiczna (opcjonalnie)',
        'exNationality': 'Np.: Polak',
        'selectBirthDate': 'Wybierz datę urodzenia',
        'selectLanguage': 'Wybierz język',
        'tellAboutYou': 'Opowiedz nam coś o sobie...',
        'successMessage': '✅ Profil został pomyślnie zaktualizowany!',
        'updated': 'Zaktualizowano',
      },
    },

    'pt': {
      'name': 'Português',
      'flag': '🇵🇹',
      'translations': {
        'title': 'Editar perfil',
        'email': 'E-mail',
        'name': 'Nome',
        'displayName': 'Nome de exibição',
        'nationality': 'Nacionalidade',
        'birthDate': 'Data de nascimento',
        'language': 'Idioma preferido',
        'bio': 'Biografia',
        'save': 'SALVAR ALTERAÇÕES',
        'lastUpdate': 'Última atualização',
        'tapToChange': 'Toque para alterar',
        'enterName': 'Digite seu nome',
        'publicName': 'Nome público (opcional)',
        'exNationality': 'Ex.: Italiano',
        'selectBirthDate': 'Selecione a data de nascimento',
        'selectLanguage': 'Selecione o idioma',
        'tellAboutYou': 'Conte algo sobre você...',
        'successMessage': '✅ Perfil atualizado com sucesso!',
        'updated': 'Atualizado',
      },
    },

    'ro': {
      'name': 'Română',
      'flag': '🇷🇴',
      'translations': {
        'title': 'Editează profilul',
        'email': 'Email',
        'name': 'Nume',
        'displayName': 'Nume afișat',
        'nationality': 'Naționalitate',
        'birthDate': 'Data nașterii',
        'language': 'Limba preferată',
        'bio': 'Bio',
        'save': 'SALVEAZĂ MODIFICĂRILE',
        'lastUpdate': 'Ultima actualizare',
        'tapToChange': 'Atinge pentru a schimba',
        'enterName': 'Introdu numele tău',
        'publicName': 'Nume public (opțional)',
        'exNationality': 'Ex.: Român',
        'selectBirthDate': 'Selectează data nașterii',
        'selectLanguage': 'Selectează limba',
        'tellAboutYou': 'Spune-ne ceva despre tine...',
        'successMessage': '✅ Profilul a fost actualizat cu succes!',
        'updated': 'Actualizat',
      },
    },

    'sk': {
      'name': 'Slovenčina',
      'flag': '🇸🇰',
      'translations': {
        'title': 'Upraviť profil',
        'email': 'E-mail',
        'name': 'Meno',
        'displayName': 'Zobrazované meno',
        'nationality': 'Národnosť',
        'birthDate': 'Dátum narodenia',
        'language': 'Preferovaný jazyk',
        'bio': 'Bio',
        'save': 'ULOŽIŤ ZMENY',
        'lastUpdate': 'Posledná aktualizácia',
        'tapToChange': 'Klepnite pre zmenu',
        'enterName': 'Zadajte svoje meno',
        'publicName': 'Verejné meno (voliteľné)',
        'exNationality': 'Napr.: Slovák',
        'selectBirthDate': 'Vyberte dátum narodenia',
        'selectLanguage': 'Vyberte jazyk',
        'tellAboutYou': 'Povedzte nám niečo o sebe...',
        'successMessage': '✅ Profil bol úspešne aktualizovaný!',
        'updated': 'Aktualizované',
      },
    },

    'sl': {
      'name': 'Slovenščina',
      'flag': '🇸🇮',
      'translations': {
        'title': 'Uredi profil',
        'email': 'E-pošta',
        'name': 'Ime',
        'displayName': 'Prikazno ime',
        'nationality': 'Državljanstvo',
        'birthDate': 'Datum rojstva',
        'language': 'Želeni jezik',
        'bio': 'Bio',
        'save': 'SHRANI SPREMEMBE',
        'lastUpdate': 'Zadnja posodobitev',
        'tapToChange': 'Tapnite za spremembo',
        'enterName': 'Vnesite svoje ime',
        'publicName': 'Javno ime (neobvezno)',
        'exNationality': 'Npr.: Slovenec',
        'selectBirthDate': 'Izberite datum rojstva',
        'selectLanguage': 'Izberite jezik',
        'tellAboutYou': 'Povejte nam kaj o sebi...',
        'successMessage': '✅ Profil je bil uspešno posodobljen!',
        'updated': 'Posodobljeno',
      },
    },

    'sv': {
      'name': 'Svenska',
      'flag': '🇸🇪',
      'translations': {
        'title': 'Redigera profil',
        'email': 'E-post',
        'name': 'Namn',
        'displayName': 'Visningsnamn',
        'nationality': 'Nationalitet',
        'birthDate': 'Födelsedatum',
        'language': 'Föredraget språk',
        'bio': 'Bio',
        'save': 'SPARA ÄNDRINGAR',
        'lastUpdate': 'Senaste uppdatering',
        'tapToChange': 'Tryck för att ändra',
        'enterName': 'Ange ditt namn',
        'publicName': 'Offentligt namn (valfritt)',
        'exNationality': 'T.ex.: Svensk',
        'selectBirthDate': 'Välj födelsedatum',
        'selectLanguage': 'Välj språk',
        'tellAboutYou': 'Berätta något om dig själv...',
        'successMessage': '✅ Profil uppdaterad framgångsrikt!',
        'updated': 'Uppdaterad',
      },
    },

    'hu': {
      'name': 'Magyar',
      'flag': '🇭🇺',
      'translations': {
        'title': 'Profil szerkesztése',
        'email': 'E-mail',
        'name': 'Név',
        'displayName': 'Megjelenítendő név',
        'nationality': 'Nemzetiség',
        'birthDate': 'Születési dátum',
        'language': 'Preferált nyelv',
        'bio': 'Bio',
        'save': 'VÁLTOZÁSOK MENTÉSE',
        'lastUpdate': 'Utolsó frissítés',
        'tapToChange': 'Koppintson a módosításhoz',
        'enterName': 'Adja meg a nevét',
        'publicName': 'Nyilvános név (opcionális)',
        'exNationality': 'Pl.: Magyar',
        'selectBirthDate': 'Válassza ki a születési dátumot',
        'selectLanguage': 'Válassza ki a nyelvet',
        'tellAboutYou': 'Mesélj magadról valamit...',
        'successMessage': '✅ A profil sikeresen frissítve!',
        'updated': 'Frissítve',
      },
    },

    'hr': {
      'name': 'Hrvatski',
      'flag': '🇭🇷',
      'translations': {
        'title': 'Uredi profil',
        'email': 'E-pošta',
        'name': 'Ime',
        'displayName': 'Prikazano ime',
        'nationality': 'Nacionalnost',
        'birthDate': 'Datum rođenja',
        'language': 'Preferirani jezik',
        'bio': 'Bio',
        'save': 'SPREMI PROMJENE',
        'lastUpdate': 'Zadnje ažuriranje',
        'tapToChange': 'Dodirnite za promjenu',
        'enterName': 'Unesite svoje ime',
        'publicName': 'Javno ime (opcionalno)',
        'exNationality': 'Npr.: Hrvat',
        'selectBirthDate': 'Odaberite datum rođenja',
        'selectLanguage': 'Odaberite jezik',
        'tellAboutYou': 'Recite nam nešto o sebi...',
        'successMessage': '✅ Profil je uspješno ažuriran!',
        'updated': 'Ažurirano',
      },
    },

    'nl': {
      'name': 'Nederlands',
      'flag': '🇳🇱',
      'translations': {
        'title': 'Profiel bewerken',
        'email': 'E-mail',
        'name': 'Naam',
        'displayName': 'Weergavenaam',
        'nationality': 'Nationaliteit',
        'birthDate': 'Geboortedatum',
        'language': 'Voorkeurstaal',
        'bio': 'Bio',
        'save': 'WIJZIGINGEN OPSLAAN',
        'lastUpdate': 'Laatste update',
        'tapToChange': 'Tik om te wijzigen',
        'enterName': 'Voer uw naam in',
        'publicName': 'Publieke naam (optioneel)',
        'exNationality': 'Bijv.: Nederlands',
        'selectBirthDate': 'Selecteer geboortedatum',
        'selectLanguage': 'Selecteer taal',
        'tellAboutYou': 'Vertel ons iets over jezelf...',
        'successMessage': '✅ Profiel succesvol bijgewerkt!',
        'updated': 'Bijgewerkt',
      },
    },
  };

  String _t(String key) {
    final translations =
        _languages[_selectedLanguage]?['translations'] as Map<String, String>?;
    if (translations != null && translations.containsKey(key)) {
      return translations[key]!;
    }
    // Fallback to Italian
    return (_languages['it']?['translations'] as Map<String, String>)[key] ??
        key;
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      try {
        final response = await supabase
            .from('profiles')
            .select()
            .eq('id', user.id)
            .single();

        setState(() {
          _nameController.text = response['name'] ?? '';
          _displayNameController.text = response['display_name'] ?? '';
          _bioController.text = response['bio'] ?? '';
          _nationalityController.text = response['nazionalita'] ?? '';
          _selectedLanguage = response['lingua_scelta'] ?? 'it';
          _avatarUrl = response['avatar_url'];
          _lastUpdated = response['updated_at'];

          if (response['birth_date'] != null) {
            _birthDate = DateTime.parse(response['birth_date']);
          }
        });
      } catch (e) {
        print('Errore caricamento profilo: $e');
        setState(() {
          _nameController.text = user.userMetadata?['name'] ?? '';
          _bioController.text = user.userMetadata?['bio'] ?? '';
          _avatarUrl = user.userMetadata?['avatar_url'];
        });
      }
    }
  }

  // Funzione per ottenere il MIME type corretto
  String _getMimeType(String extension) {
    final ext = extension.toLowerCase();
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'heic':
        return 'image/heic';
      case 'heif':
        return 'image/heif';
      default:
        return 'image/jpeg'; // Fallback
    }
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();

      // Mostra dialog per scegliere la sorgente
      final source = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Seleziona sorgente',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF7C3AED),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7C3AED).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.photo_library, color: Color(0xFF7C3AED)),
                ),
                title: const Text('Galleria'),
                subtitle: const Text(
                  'Scegli dalla galleria',
                  style: TextStyle(fontSize: 12),
                ),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7C3AED).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.camera_alt, color: Color(0xFF7C3AED)),
                ),
                title: const Text('Fotocamera'),
                subtitle: const Text(
                  'Scatta una foto',
                  style: TextStyle(fontSize: 12),
                ),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
            ],
          ),
        ),
      );

      if (source == null) return;

      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        // Verifica formato file
        final extension = image.path.split('.').last.toLowerCase();
        final validFormats = [
          'jpg',
          'jpeg',
          'png',
          'gif',
          'webp',
          'heic',
          'heif',
        ];

        if (!validFormats.contains(extension)) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.error, color: Colors.white),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Formato non supportato.\nUsa: JPG, PNG, GIF, WEBP, HEIC',
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 4),
              ),
            );
          }
          return;
        }

        // Verifica dimensione (max 5MB)
        final fileSize = await image.length();
        final fileSizeMB = fileSize / (1024 * 1024);

        if (fileSize > 5 * 1024 * 1024) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'File troppo grande (${fileSizeMB.toStringAsFixed(1)}MB).\nMassimo: 5MB',
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 4),
              ),
            );
          }
          return;
        }

        setState(() {
          _imageFile = File(image.path);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Immagine selezionata (${fileSizeMB.toStringAsFixed(1)}MB)',
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF6BCF7F),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Errore selezione immagine: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(child: Text('Errore: ${e.toString()}')),
              ],
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<String?> _uploadAvatar() async {
    if (_imageFile == null) return null;

    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      // Genera un nome file unico con timestamp e user ID
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = _imageFile!.path.split('.').last.toLowerCase();
      final fileName = '${user.id}_$timestamp.$extension';
      final filePath = 'avatars/$fileName';

      print('📤 Upload avatar: $filePath');
      print('📁 File size: ${await _imageFile!.length()} bytes');

      // Leggi i bytes del file
      final bytes = await _imageFile!.readAsBytes();
      final mimeType = _getMimeType(extension);

      print('📋 MIME type: $mimeType');

      // Upload con contentType specifico
      await supabase.storage
          .from('profiles')
          .uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(contentType: mimeType, upsert: true),
          );

      final publicUrl = supabase.storage
          .from('profiles')
          .getPublicUrl(filePath);
      print('✅ Avatar caricato con successo: $publicUrl');
      return publicUrl;
    } catch (e) {
      print('❌ Errore upload avatar: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('Errore caricamento avatar: ${e.toString()}'),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
      return null;
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF7C3AED),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _birthDate) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Text(
                _t('selectLanguage'),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7C3AED),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _languages.length,
                  itemBuilder: (context, index) {
                    final langCode = _languages.keys.elementAt(index);
                    final langData = _languages[langCode]!;
                    final isSelected = _selectedLanguage == langCode;

                    return ListTile(
                      leading: Text(
                        langData['flag'] as String,
                        style: const TextStyle(fontSize: 32),
                      ),
                      title: Text(
                        langData['name'] as String,
                        style: TextStyle(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected ? const Color(0xFF7C3AED) : Colors.black,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: Color(0xFF7C3AED))
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedLanguage = langCode;
                        });
                        // NUOVO: Notifica il cambio di lingua a tutti i listener
                        _languageService.setLanguage(langCode);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception('Utente non autenticato');

      // Upload avatar se presente
      String? newAvatarUrl = _imageFile != null
          ? await _uploadAvatar()
          : _avatarUrl;
      print('💾 Salvataggio avatar URL: $newAvatarUrl');

      final now = DateTime.now().toIso8601String();

      // Aggiorna i metadati dell'utente con avatar_url
      await supabase.auth.updateUser(
        UserAttributes(
          data: {
            'name': _nameController.text.trim(),
            'display_name': _displayNameController.text.trim(),
            'bio': _bioController.text.trim(),
            'nazionalita': _nationalityController.text.trim(),
            'lingua_scelta': _selectedLanguage,
            'birth_date': _birthDate?.toIso8601String(),
            'avatar_url':
                newAvatarUrl, // IMPORTANTE: Salva avatar_url nei metadati
            'last_login_date': now,
          },
        ),
      );

      // Incrementa counter_login_in_month
      final currentMonth = DateTime.now().month;
      final currentYear = DateTime.now().year;

      final profileData = await supabase
          .from('profiles')
          .select('counter_login_in_month, last_login_date')
          .eq('id', user.id)
          .maybeSingle();

      int counterLoginInMonth = 1;
      if (profileData != null && profileData['last_login_date'] != null) {
        final lastLogin = DateTime.parse(profileData['last_login_date']);
        if (lastLogin.month == currentMonth && lastLogin.year == currentYear) {
          counterLoginInMonth =
              (profileData['counter_login_in_month'] ?? 0) + 1;
        }
      }

      // Aggiorna nel database
      await supabase.from('profiles').upsert({
        'id': user.id,
        'email': user.email,
        'name': _nameController.text.trim(),
        'display_name': _displayNameController.text.trim(),
        'bio': _bioController.text.trim(),
        'nazionalita': _nationalityController.text.trim(),
        'lingua_scelta': _selectedLanguage,
        'birth_date': _birthDate?.toIso8601String(),
        'avatar_url': newAvatarUrl,
        'last_login_date': now,
        'counter_login_in_month': counterLoginInMonth,
        'updated_at': now,
      });

      // Ricarica i dati per ottenere l'avatar aggiornato
      await _loadUserData();

      // NUOVO: Notifica il cambio di lingua a tutti i listener
      _languageService.setLanguage(_selectedLanguage);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _t('successMessage'),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      if (_lastUpdated != null)
                        Text(
                          '${_t('updated')}: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(_lastUpdated!))}',
                          style: const TextStyle(fontSize: 12),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF6BCF7F),
            duration: const Duration(seconds: 3),
          ),
        );

        // Torna indietro con risultato true per ricaricare la pagina precedente
        Navigator.pop(context, true);
      }
    } catch (e) {
      print('❌ Errore completo: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(child: Text('Errore: ${e.toString()}')),
              ],
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _displayNameController.dispose();
    _bioController.dispose();
    _nationalityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFF7C3AED),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                _t('title'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF7C3AED),
                      Color(0xFFA855F7),
                      Color(0xFFC084FC),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: _pickImage,
                            child: Stack(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 15,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                    image: _imageFile != null
                                        ? DecorationImage(
                                            image: FileImage(_imageFile!),
                                            fit: BoxFit.cover,
                                          )
                                        : (_avatarUrl != null
                                              ? DecorationImage(
                                                  image: NetworkImage(
                                                    _avatarUrl!,
                                                  ),
                                                  fit: BoxFit.cover,
                                                )
                                              : null),
                                    gradient:
                                        _imageFile == null && _avatarUrl == null
                                        ? const LinearGradient(
                                            colors: [
                                              Color(0xFFFF6B9D),
                                              Color(0xFFFFA06B),
                                              Color(0xFFFFD93D),
                                            ],
                                          )
                                        : null,
                                  ),
                                  child:
                                      _imageFile == null && _avatarUrl == null
                                      ? Center(
                                          child: Text(
                                            user?.email?[0].toUpperCase() ??
                                                'U',
                                            style: const TextStyle(
                                              fontSize: 40,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF7C3AED),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _t('tapToChange'),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_lastUpdated != null)
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7C3AED).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF7C3AED).withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Color(0xFF7C3AED),
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                '${_t('lastUpdate')}: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(_lastUpdated!))}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF7C3AED),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Email (non modificabile)
                    _buildLabel(_t('email')),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.email, color: Colors.grey[600]),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              user?.email ?? '',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Nome
                    _buildLabel(_t('name')),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      decoration: _buildInputDecoration(
                        _t('enterName'),
                        Icons.person,
                        const Color(0xFF7C3AED),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Inserisci il tuo nome';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Nome visualizzato
                    _buildLabel(_t('displayName')),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _displayNameController,
                      decoration: _buildInputDecoration(
                        _t('publicName'),
                        Icons.badge,
                        const Color(0xFFFF6B9D),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Nazionalità
                    _buildLabel(_t('nationality')),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nationalityController,
                      decoration: _buildInputDecoration(
                        _t('exNationality'),
                        Icons.public,
                        const Color(0xFF10B981),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Data di nascita
                    _buildLabel(_t('birthDate')),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: _selectDate,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.cake, color: Color(0xFFEC4899)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _birthDate != null
                                    ? DateFormat(
                                        'dd/MM/yyyy',
                                      ).format(_birthDate!)
                                    : _t('selectBirthDate'),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: _birthDate != null
                                      ? Colors.black
                                      : Colors.grey[500],
                                ),
                              ),
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: Colors.grey[400],
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Lingua
                    _buildLabel(_t('language')),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: _showLanguageSelector,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Row(
                          children: [
                            Text(
                              (_languages[_selectedLanguage]?['flag']
                                      as String?) ??
                                  '🌐',
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                (_languages[_selectedLanguage]?['name']
                                        as String?) ??
                                    'Select language',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey[400],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Bio
                    _buildLabel(_t('bio')),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _bioController,
                      maxLines: 4,
                      maxLength: 200,
                      decoration: _buildInputDecoration(
                        _t('tellAboutYou'),
                        Icons.description,
                        const Color(0xFF6BCF7F),
                        alignIconTop: true,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Pulsante Salva
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _updateProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7C3AED),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.save, color: Colors.white),
                                  const SizedBox(width: 8),
                                  Text(
                                    _t('save'),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.grey[700],
      ),
    );
  }

  InputDecoration _buildInputDecoration(
    String hint,
    IconData icon,
    Color iconColor, {
    bool alignIconTop = false,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: alignIconTop
          ? Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Icon(icon, color: iconColor),
            )
          : Icon(icon, color: iconColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: iconColor, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }
}