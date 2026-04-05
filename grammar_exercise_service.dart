import 'package:flutter/material.dart';
import 'package:login_ora/data/models/grammar_model.dart';


class GrammarExerciseService {
  // 26 lingue supportate
  static const List<String> supportedLanguages = [
    'en', 'it', 'de', 'es', 'fr', 'ru', 'zh', 'bg', 'cs', 'da',
    'et', 'fi', 'el', 'ga', 'lv', 'lt', 'mt', 'nl', 'pl', 'pt',
    'ro', 'sk', 'sl', 'sv', 'hu', 'hr'
  ];

  // Database tempi grammaticali principali
  static List<GrammarTense> getAllTenses() {
    return [
      _getPresentSimple(),
      _getPresentContinuous(),
      _getPastSimple(),
      _getPastContinuous(),
      _getPresentPerfect(),
      _getFutureSimple(),
      _getFirstConditional(),
      _getSecondConditional(),
    ];
  }

  static GrammarTense _getPresentSimple() {
    return GrammarTense(
      id: 'present_simple',
      name: 'Present Simple',
      difficulty: 1,
      nameTranslations: {
        'en': 'Present Simple',
        'it': 'Presente Semplice',
        'de': 'Präsens',
        'es': 'Presente Simple',
        'fr': 'Présent Simple',
        'ru': 'Настоящее простое',
        'zh': '一般现在时',
        'bg': 'Сегашно просто',
        'cs': 'Přítomný čas prostý',
        'da': 'Nutid',
        'et': 'Lihtolevik',
        'fi': 'Preesens',
        'el': 'Απλός Ενεστώτας',
        'ga': 'An Aimsir Láithreach',
        'lv': 'Vienkāršā tagadne',
        'lt': 'Paprastasis esamasis',
        'mt': 'Preżent Sempliċi',
        'nl': 'Tegenwoordige Tijd',
        'pl': 'Czas teraźniejszy prosty',
        'pt': 'Presente Simples',
        'ro': 'Prezent Simplu',
        'sk': 'Prítomný čas jednoduchý',
        'sl': 'Sedanjik',
        'sv': 'Presens',
        'hu': 'Jelen idő',
        'hr': 'Sadašnje jednostavno',
      },
      descriptions: {
        'en': 'Used for habits, routines, and general truths',
        'it': 'Usato per abitudini, routine e verità generali',
        'de': 'Wird für Gewohnheiten, Routinen und allgemeine Wahrheiten verwendet',
        'es': 'Usado para hábitos, rutinas y verdades generales',
        'fr': 'Utilisé pour les habitudes, routines et vérités générales',
        'ru': 'Используется для привычек, рутины и общих истин',
        'zh': '用于习惯、常规和一般真理',
        'bg': 'Използва се за навици, рутини и общи истини',
        'cs': 'Používá se pro návyky, rutiny a obecné pravdy',
        'da': 'Bruges til vaner, rutiner og generelle sandheder',
        'et': 'Kasutatakse harjumuste, rutiinide ja üldiste tõdede jaoks',
        'fi': 'Käytetään tavoille, rutiineille ja yleisille totuuksille',
        'el': 'Χρησιμοποιείται για συνήθειες, ρουτίνες και γενικές αλήθειες',
        'ga': 'Úsáidtear é do nósanna, gnásanna agus fíricí ginearálta',
        'lv': 'Izmanto ieradumiem, rutīnām un vispārīgām patiesībām',
        'lt': 'Naudojamas įpročiams, rutinoms ir bendrosioms tiesoms',
        'mt': 'Jintuża għal drawwiet, rutini u veritajiet ġenerali',
        'nl': 'Gebruikt voor gewoonten, routines en algemene waarheden',
        'pl': 'Używany do nawyków, rutyn i ogólnych prawd',
        'pt': 'Usado para hábitos, rotinas e verdades gerais',
        'ro': 'Folosit pentru obiceiuri, rutine și adevăruri generale',
        'sk': 'Používa sa pre návyky, rutiny a všeobecné pravdy',
        'sl': 'Uporablja se za navade, rutine in splošne resnice',
        'sv': 'Används för vanor, rutiner och allmänna sanningar',
        'hu': 'Szokások, rutinok és általános igazságok kifejezésére használatos',
        'hr': 'Koristi se za navike, rutine i opće istine',
      },
      usageExamples: {
        'en': ['I work every day', 'She speaks English', 'The sun rises in the east'],
        'it': ['Lavoro ogni giorno', 'Lei parla inglese', 'Il sole sorge a est'],
        'de': ['Ich arbeite jeden Tag', 'Sie spricht Englisch', 'Die Sonne geht im Osten auf'],
        'es': ['Trabajo todos los días', 'Ella habla inglés', 'El sol sale por el este'],
        'fr': ['Je travaille tous les jours', 'Elle parle anglais', 'Le soleil se lève à l\'est'],
        'ru': ['Я работаю каждый день', 'Она говорит по-английски', 'Солнце встает на востоке'],
        'zh': ['我每天工作', '她说英语', '太阳从东方升起'],
        'bg': ['Работя всеки ден', 'Тя говори английски', 'Слънцето изгрява на изток'],
        'cs': ['Pracuji každý den', 'Mluví anglicky', 'Slunce vychází na východě'],
        'da': ['Jeg arbejder hver dag', 'Hun taler engelsk', 'Solen står op i øst'],
        'et': ['Töötan iga päev', 'Ta räägib inglise keelt', 'Päike tõuseb idas'],
        'fi': ['Työskentelen joka päivä', 'Hän puhuu englantia', 'Aurinko nousee idässä'],
        'el': ['Δουλεύω κάθε μέρα', 'Μιλάει αγγλικά', 'Ο ήλιος ανατέλλει στην ανατολή'],
        'ga': ['Oibrím gach lá', 'Labhraíonn sí Béarla', 'Éiríonn an ghrian san oirthear'],
        'lv': ['Es strādāju katru dienu', 'Viņa runā angliski', 'Saule lec austrumos'],
        'lt': ['Dirbu kasdien', 'Ji kalba angliškai', 'Saulė teka rytuose'],
        'mt': ['Naħdem kuljum', 'Hi titkellem l-Ingliż', 'Ix-xemx titla\' fil-lvant'],
        'nl': ['Ik werk elke dag', 'Ze spreekt Engels', 'De zon komt op in het oosten'],
        'pl': ['Pracuję codziennie', 'Ona mówi po angielsku', 'Słońce wschodzi na wschodzie'],
        'pt': ['Trabalho todos os dias', 'Ela fala inglês', 'O sol nasce no leste'],
        'ro': ['Lucrez în fiecare zi', 'Ea vorbește engleza', 'Soarele răsare la est'],
        'sk': ['Pracujem každý deň', 'Hovorí anglicky', 'Slnko vychádza na východe'],
        'sl': ['Delam vsak dan', 'Govori angleško', 'Sonce vzhaja na vzhodu'],
        'sv': ['Jag arbetar varje dag', 'Hon talar engelska', 'Solen går upp i öster'],
        'hu': ['Minden nap dolgozom', 'Ő angolul beszél', 'A nap keleten kel fel'],
        'hr': ['Radim svaki dan', 'Ona govori engleski', 'Sunce izlazi na istoku'],
      },
      formationRules: {
        'en': 'Subject + base verb (add -s/-es for third person singular)',
        'it': 'Soggetto + verbo base (aggiungi -s/-es per terza persona singolare)',
        'de': 'Subjekt + Basisverb (füge -s/-es für die dritte Person Singular hinzu)',
        'es': 'Sujeto + verbo base (añade -s/-es para tercera persona singular)',
        'fr': 'Sujet + verbe de base (ajoute -s/-es pour la troisième personne du singulier)',
        'ru': 'Подлежащее + базовая форма глагола (добавь -s/-es для третьего лица единственного числа)',
        'zh': '主语 + 动词原形（第三人称单数加-s/-es）',
        'bg': 'Подлог + основна форма на глагола (добави -s/-es за трето лице единствено число)',
        'cs': 'Podmět + základní tvar slovesa (přidej -s/-es pro třetí osobu jednotného čísla)',
        'da': 'Subjekt + grundform af verbum (tilføj -s/-es for tredje person ental)',
        'et': 'Alus + verbi põhivorm (lisa -s/-es kolmanda isiku ainsusele)',
        'fi': 'Subjekti + verbin perusmuoto (lisää -s/-es kolmannelle persoonalle yksikössä)',
        'el': 'Υποκείμενο + βασική μορφή ρήματος (πρόσθεσε -s/-es για τρίτο πρόσωπο ενικού)',
        'ga': 'Ainmfhocal + bun-bhriathar (cuir -s/-es leis an tríú pearsa uatha)',
        'lv': 'Teikuma priekšmets + verba pamatforma (pievieno -s/-es trešajai personai vienskaitlī)',
        'lt': 'Veiksnys + pagrindinis veiksmažodžio forma (pridėk -s/-es trečiajam asmeniui vienaskaita)',
        'mt': 'Suġġett + forma bażika tal-verb (żid -s/-es għat-tielet persuna singulari)',
        'nl': 'Onderwerp + basisvorm werkwoord (voeg -s/-es toe voor derde persoon enkelvoud)',
        'pl': 'Podmiot + podstawowa forma czasownika (dodaj -s/-es dla trzeciej osoby liczby pojedynczej)',
        'pt': 'Sujeito + verbo base (adicione -s/-es para terceira pessoa singular)',
        'ro': 'Subiect + verb de bază (adaugă -s/-es pentru persoana a treia singular)',
        'sk': 'Podmet + základný tvar slovesa (pridaj -s/-es pre tretiu osobu jednotného čísla)',
        'sl': 'Osebek + osnovna oblika glagola (dodaj -s/-es za tretjo osebo ednine)',
        'sv': 'Subjekt + grundform av verb (lägg till -s/-es för tredje person singular)',
        'hu': 'Alany + alapige (hozzáadás -s/-es harmadik személy egyes szám)',
        'hr': 'Subjekt + osnovna forma glagola (dodaj -s/-es za treće lice jednine)',
      },
    );
  }

  static GrammarTense _getPresentContinuous() {
    return GrammarTense(
      id: 'present_continuous',
      name: 'Present Continuous',
      difficulty: 2,
      nameTranslations: {
        'en': 'Present Continuous',
        'it': 'Presente Continuo',
        'de': 'Verlaufsform der Gegenwart',
        'es': 'Presente Continuo',
        'fr': 'Présent Continu',
        'ru': 'Настоящее длительное',
        'zh': '现在进行时',
        'bg': 'Сегашно продължително',
        'cs': 'Přítomný čas průběhový',
        'da': 'Nutid løbende',
        'et': 'Kestev olevik',
        'fi': 'Jatkuva preesens',
        'el': 'Συνεχής Ενεστώτας',
        'ga': 'An Aimsir Láithreach Leanúnach',
        'lv': 'Ilgstoša tagadne',
        'lt': 'Esamasis tęstinis',
        'mt': 'Preżent Kontinwu',
        'nl': 'Duurvorm Tegenwoordige Tijd',
        'pl': 'Czas teraźniejszy ciągły',
        'pt': 'Presente Contínuo',
        'ro': 'Prezent Continuu',
        'sk': 'Prítomný čas priebehový',
        'sl': 'Sedanji čas trajanja',
        'sv': 'Pågående presens',
        'hu': 'Folyamatos jelen',
        'hr': 'Sadašnje trajno',
      },
      descriptions: {
        'en': 'Used for actions happening now or temporary situations',
        'it': 'Usato per azioni in corso o situazioni temporanee',
        'de': 'Wird für Handlungen verwendet, die jetzt stattfinden oder vorübergehende Situationen',
        'es': 'Usado para acciones que ocurren ahora o situaciones temporales',
        'fr': 'Utilisé pour les actions en cours ou les situations temporaires',
        'ru': 'Используется для действий, происходящих сейчас, или временных ситуаций',
        'zh': '用于正在发生的动作或临时情况',
        'bg': 'Използва се за действия, които се случват сега, или временни ситуации',
        'cs': 'Používá se pro akce probíhající nyní nebo dočasné situace',
        'da': 'Bruges til handlinger der sker nu eller midlertidige situationer',
        'et': 'Kasutatakse praegu toimuvate tegude või ajutiste olukordade jaoks',
        'fi': 'Käytetään toiminnoille, jotka tapahtuvat nyt tai väliaikaisille tilanteille',
        'el': 'Χρησιμοποιείται για ενέργειες που συμβαίνουν τώρα ή προσωρινές καταστάσεις',
        'ga': 'Úsáidtear é do ghníomhartha atá ag tarlú anois nó do chásanna sealadacha',
        'lv': 'Izmanto darbībām, kas notiek tagad vai pagaidu situācijām',
        'lt': 'Naudojamas veiksmams, vykstantiems dabar, arba laikinoms situacijoms',
        'mt': 'Jintuża għal azzjonijiet li qed jiġru issa jew sitwazzjonijiet temporanji',
        'nl': 'Gebruikt voor handelingen die nu plaatsvinden of tijdelijke situaties',
        'pl': 'Używany do czynności dziejących się teraz lub sytuacji tymczasowych',
        'pt': 'Usado para ações que estão acontecendo agora ou situações temporárias',
        'ro': 'Folosit pentru acțiuni care se întâmplă acum sau situații temporare',
        'sk': 'Používa sa pre akcie prebiehajúce teraz alebo dočasné situácie',
        'sl': 'Uporablja se za dejanja, ki se dogajajo sedaj, ali začasne situacije',
        'sv': 'Används för handlingar som pågår nu eller tillfälliga situationer',
        'hu': 'Jelenleg zajló cselekvések vagy ideiglenes helyzetek kifejezésére használatos',
        'hr': 'Koristi se za radnje koje se događaju sada ili privremene situacije',
      },
      usageExamples: {
        'en': ['I am working now', 'She is studying English', 'They are playing football'],
        'it': ['Sto lavorando ora', 'Sta studiando inglese', 'Stanno giocando a calcio'],
        'de': ['Ich arbeite gerade', 'Sie lernt Englisch', 'Sie spielen Fußball'],
        'es': ['Estoy trabajando ahora', 'Está estudiando inglés', 'Están jugando fútbol'],
        'fr': ['Je travaille maintenant', 'Elle étudie l\'anglais', 'Ils jouent au football'],
        'ru': ['Я работаю сейчас', 'Она изучает английский', 'Они играют в футбол'],
        'zh': ['我现在在工作', '她在学英语', '他们在踢足球'],
        'bg': ['Работя в момента', 'Тя учи английски', 'Те играят футбол'],
        'cs': ['Právě teď pracuji', 'Studuje angličtinu', 'Hrají fotbal'],
        'da': ['Jeg arbejder nu', 'Hun studerer engelsk', 'De spiller fodbold'],
        'et': ['Ma töötan praegu', 'Ta õpib inglise keelt', 'Nad mängivad jalgpalli'],
        'fi': ['Työskentelen nyt', 'Hän opiskelee englantia', 'He pelaavat jalkapalloa'],
        'el': ['Δουλεύω τώρα', 'Μελετά αγγλικά', 'Παίζουν ποδόσφαιρο'],
        'ga': ['Táim ag obair anois', 'Tá sí ag staidéar Béarla', 'Tá siad ag imirt peile'],
        'lv': ['Es tagad strādāju', 'Viņa mācās angļu valodu', 'Viņi spēlē futbolu'],
        'lt': ['Aš dabar dirbu', 'Ji mokosi anglų kalbos', 'Jie žaidžia futbolą'],
        'mt': ['Jien qed naħdem issa', 'Hi qed tistudja l-Ingliż', 'Huma qed jilgħabu futbol'],
        'nl': ['Ik werk nu', 'Ze studeert Engels', 'Ze spelen voetbal'],
        'pl': ['Pracuję teraz', 'Ona uczy się angielskiego', 'Oni grają w piłkę nożną'],
        'pt': ['Estou trabalhando agora', 'Ela está estudando inglês', 'Eles estão jogando futebol'],
        'ro': ['Lucrez acum', 'Ea studiază engleza', 'Ei joacă fotbal'],
        'sk': ['Teraz pracujem', 'Študuje angličtinu', 'Hrajú futbal'],
        'sl': ['Zdaj delam', 'Študira angleščino', 'Igrajo nogomet'],
        'sv': ['Jag arbetar nu', 'Hon studerar engelska', 'De spelar fotboll'],
        'hu': ['Most dolgozom', 'Angolt tanul', 'Fociznak'],
        'hr': ['Radim sada', 'Ona uči engleski', 'Oni igraju nogomet'],
      },
      formationRules: {
        'en': 'Subject + am/is/are + verb-ing',
        'it': 'Soggetto + am/is/are + verbo-ing',
        'de': 'Subjekt + am/is/are + Verb-ing',
        'es': 'Sujeto + am/is/are + verbo-ing',
        'fr': 'Sujet + am/is/are + verbe-ing',
        'ru': 'Подлежащее + am/is/are + глагол-ing',
        'zh': '主语 + am/is/are + 动词-ing',
        'bg': 'Подлог + am/is/are + глагол-ing',
        'cs': 'Podmět + am/is/are + sloveso-ing',
        'da': 'Subjekt + am/is/are + verbum-ing',
        'et': 'Alus + am/is/are + tegusõna-ing',
        'fi': 'Subjekti + am/is/are + verbi-ing',
        'el': 'Υποκείμενο + am/is/are + ρήμα-ing',
        'ga': 'Ainmfhocal + am/is/are + briathar-ing',
        'lv': 'Teikuma priekšmets + am/is/are + darbības vārds-ing',
        'lt': 'Veiksnys + am/is/are + veiksmažodis-ing',
        'mt': 'Suġġett + am/is/are + verb-ing',
        'nl': 'Onderwerp + am/is/are + werkwoord-ing',
        'pl': 'Podmiot + am/is/are + czasownik-ing',
        'pt': 'Sujeito + am/is/are + verbo-ing',
        'ro': 'Subiect + am/is/are + verb-ing',
        'sk': 'Podmet + am/is/are + sloveso-ing',
        'sl': 'Osebek + am/is/are + glagol-ing',
        'sv': 'Subjekt + am/is/are + verb-ing',
        'hu': 'Alany + am/is/are + ige-ing',
        'hr': 'Subjekt + am/is/are + glagol-ing',
      },
    );
  }

  // Metodi per generare esercizi per ogni tempo
  static List<GrammarExercise> getExercisesForTense(String tenseId) {
    switch (tenseId) {
      case 'present_simple':
        return _getPresentSimpleExercises();
      case 'present_continuous':
        return _getPresentContinuousExercises();
      default:
        return [];
    }
  }

  static List<GrammarExercise> _getPresentSimpleExercises() {
    return [
      // Exercise 1: Fill in the blank
      GrammarExercise(
        id: 'ps_ex_001',
        tenseId: 'present_simple',
        type: GrammarExerciseType.fillInBlank,
        difficulty: 1,
        questions: {
          'en': 'She _____ (work) in a bank.',
          'it': 'Lei _____ (lavorare) in una banca.',
          'de': 'Sie _____ (arbeiten) in einer Bank.',
          'es': 'Ella _____ (trabajar) en un banco.',
          'fr': 'Elle _____ (travailler) dans une banque.',
          'ru': 'Она _____ (работать) в банке.',
          'zh': '她在银行_____ (工作)。',
          'bg': 'Тя _____ (работи) в банка.',
          'cs': 'Ona _____ (pracovat) v bance.',
          'da': 'Hun _____ (arbejde) i en bank.',
          'et': 'Ta _____ (töötama) pangas.',
          'fi': 'Hän _____ (työskennellä) pankissa.',
          'el': 'Αυτή _____ (εργάζομαι) σε τράπεζα.',
          'ga': 'Oibríonn sí _____ (obair) i mbanc.',
          'lv': 'Viņa _____ (strādāt) bankā.',
          'lt': 'Ji _____ (dirbti) banke.',
          'mt': 'Hi _____ (taħdem) f\'bank.',
          'nl': 'Ze _____ (werken) in een bank.',
          'pl': 'Ona _____ (pracować) w banku.',
          'pt': 'Ela _____ (trabalhar) em um banco.',
          'ro': 'Ea _____ (lucra) într-o bancă.',
          'sk': 'Ona _____ (pracovať) v banke.',
          'sl': 'Ona _____ (delati) v banki.',
          'sv': 'Hon _____ (arbeta) på en bank.',
          'hu': 'Ő _____ (dolgozni) egy bankban.',
          'hr': 'Ona _____ (raditi) u banci.',
        },
        options: {
          'en': ['work', 'works', 'working', 'worked'],
          'it': ['lavora', 'lavorare', 'lavorando', 'lavorato'],
          'de': ['arbeitet', 'arbeiten', 'arbeitend', 'gearbeitet'],
          'es': ['trabaja', 'trabajar', 'trabajando', 'trabajado'],
          'fr': ['travaille', 'travailler', 'travaillant', 'travaillé'],
          'ru': ['работает', 'работать', 'работая', 'работал'],
          'zh': ['工作', '工作着', '工作了', '工作过'],
          'bg': ['работи', 'работя', 'работейки', 'работил'],
          'cs': ['pracuje', 'pracovat', 'pracující', 'pracoval'],
          'da': ['arbejder', 'arbejde', 'arbejdende', 'arbejdede'],
          'et': ['töötab', 'töötama', 'töötades', 'töötas'],
          'fi': ['työskentelee', 'työskennellä', 'työskentelevä', 'työskenteli'],
          'el': ['εργάζεται', 'εργάζομαι', 'εργαζόμενος', 'εργάστηκε'],
          'ga': ['oibríonn', 'obair', 'ag obair', 'd\'oibrigh'],
          'lv': ['strādā', 'strādāt', 'strādājot', 'strādāja'],
          'lt': ['dirba', 'dirbti', 'dirbantis', 'dirbo'],
          'mt': ['taħdem', 'taħdem', 'taħdem', 'ħadem'],
          'nl': ['werkt', 'werken', 'werkend', 'werkte'],
          'pl': ['pracuje', 'pracować', 'pracujący', 'pracował'],
          'pt': ['trabalha', 'trabalhar', 'trabalhando', 'trabalhou'],
          'ro': ['lucrează', 'lucra', 'lucrând', 'lucra'],
          'sk': ['pracuje', 'pracovať', 'pracujúci', 'pracoval'],
          'sl': ['dela', 'delati', 'delajoč', 'delal'],
          'sv': ['arbetar', 'arbeta', 'arbetande', 'arbetade'],
          'hu': ['dolgozik', 'dolgozni', 'dolgozó', 'dolgozott'],
          'hr': ['radi', 'raditi', 'radeći', 'radio'],
        },
        correctAnswers: {
          'en': 'works',
          'it': 'lavora',
          'de': 'arbeitet',
          'es': 'trabaja',
          'fr': 'travaille',
          'ru': 'работает',
          'zh': '工作',
          'bg': 'работи',
          'cs': 'pracuje',
          'da': 'arbejder',
          'et': 'töötab',
          'fi': 'työskentelee',
          'el': 'εργάζεται',
          'ga': 'oibríonn',
          'lv': 'strādā',
          'lt': 'dirba',
          'mt': 'taħdem',
          'nl': 'werkt',
          'pl': 'pracuje',
          'pt': 'trabalha',
          'ro': 'lucrează',
          'sk': 'pracuje',
          'sl': 'dela',
          'sv': 'arbetar',
          'hu': 'dolgozik',
          'hr': 'radi',
        },
        explanations: {
          'en': 'Third person singular (she/he/it) requires -s ending in Present Simple.',
          'it': 'La terza persona singolare (lei/lui) richiede la desinenza -s nel Presente Semplice.',
          'de': 'Die dritte Person Singular (sie/er/es) erfordert die Endung -s im Präsens.',
          'es': 'La tercera persona singular (ella/él) requiere la terminación -s en Presente Simple.',
          'fr': 'La troisième personne du singulier (elle/il) nécessite la terminaison -s au Présent Simple.',
          'ru': 'Третье лицо единственного числа (она/он/оно) требует окончания -s в настоящем простом времени.',
          'zh': '第三人称单数（她/他/它）在一般现在时中需要-s结尾。',
          'bg': 'Третото лице единствено число (тя/той/то) изисква окончание -s в сегашно просто време.',
          'cs': 'Třetí osoba jednotného čísla (ona/on/ono) vyžaduje koncovku -s v přítomném čase prostém.',
          'da': 'Tredje person ental (hun/han/det) kræver -s-endelse i nutid.',
          'et': 'Kolmas isik ainsus (ta) nõuab lihtolevik vormis -s lõppu.',
          'fi': 'Kolmas persoona yksikössä (hän/se) vaatii -s-päätettä preesens-muodossa.',
          'el': 'Το τρίτο πρόσωπο ενικού (αυτή/αυτός/αυτό) απαιτεί κατάληξη -s στον απλό ενεστώτα.',
          'ga': 'Teastaíonn críoch -s ón tríú pearsa uatha (sí/sé/é) san Aimsir Láithreach.',
          'lv': 'Trešā persona vienskaitlī (viņa/viņš/tas) prasa -s galotni vienkāršajā tagadnē.',
          'lt': 'Trečiasis asmuo vienaskaita (ji/jis/tai) reikalauja -s galūnės paprastajame esamajame laike.',
          'mt': 'It-tielet persuna singulari (hi/hu/hija) teħtieġ terminazzjoni -s fil-Preżent Sempliċi.',
          'nl': 'Derde persoon enkelvoud (zij/hij/het) vereist -s-uitgang in tegenwoordige tijd.',
          'pl': 'Trzecia osoba liczby pojedynczej (ona/on/ono) wymaga końcówki -s w czasie teraźniejszym prostym.',
          'pt': 'Terceira pessoa do singular (ela/ele) requer terminação -s no Presente Simples.',
          'ro': 'Persoana a treia singular (ea/el) necesită terminația -s în Prezent Simplu.',
          'sk': 'Tretia osoba jednotného čísla (ona/on/ono) vyžaduje koncovku -s v prítomnom čase jednoduchom.',
          'sl': 'Tretja oseba ednine (ona/on/ono) zahteva končnico -s v sedanjiku.',
          'sv': 'Tredje person singular (hon/han/den) kräver -s-ändelse i presens.',
          'hu': 'Harmadik személy egyes szám (ő) -s végződést igényel jelen időben.',
          'hr': 'Treće lice jednine (ona/on/ono) zahtijeva nastavak -s u sadašnjem jednostavnom.',
        },
      ),
      // Add more exercises here...
    ];
  }

  static List<GrammarExercise> _getPresentContinuousExercises() {
    return [
      // Similar structure for Present Continuous exercises
    ];
  }

  // Helper per ottenere topic organizzati
  static List<GrammarTopic> getAllTopics() {
    return [
      GrammarTopic(
        id: 'verb_tenses',
        titles: {
          'en': 'Verb Tenses',
          'it': 'Tempi Verbali',
          'de': 'Zeitformen',
          'es': 'Tiempos Verbales',
          'fr': 'Temps Verbaux',
          // ... altre 21 lingue
        },
        descriptions: {
          'en': 'Master all verb tenses',
          'it': 'Padroneggia tutti i tempi verbali',
          'de': 'Meistern Sie alle Zeitformen',
          'es': 'Domina todos los tiempos verbales',
          'fr': 'Maîtrisez tous les temps verbaux',
          // ... altre 21 lingue
        },
        icon: Icons.schedule,
        color: const Color(0xFFFFA06B),
        tenses: [
          _getPresentSimple(),
          _getPresentContinuous(),
          _getPastSimple(),
          _getFutureSimple(),
        ],
        completedLessons: 8,
        totalLessons: 12,
      ),
    ];
  }

  // Placeholder methods for other tenses
  static GrammarTense _getPastSimple() {
    return GrammarTense(
      id: 'past_simple',
      name: 'Past Simple',
      difficulty: 2,
      nameTranslations: {'en': 'Past Simple', 'it': 'Passato Semplice'},
      descriptions: {'en': 'For completed past actions', 'it': 'Per azioni passate completate'},
      usageExamples: {'en': ['I worked yesterday'], 'it': ['Ho lavorato ieri']},
      formationRules: {'en': 'Subject + verb-ed', 'it': 'Soggetto + verbo-ed'},
    );
  }

  static GrammarTense _getPastContinuous() {
    return GrammarTense(
      id: 'past_continuous',
      name: 'Past Continuous',
      difficulty: 3,
      nameTranslations: {'en': 'Past Continuous', 'it': 'Passato Continuo'},
      descriptions: {'en': 'For ongoing past actions', 'it': 'Per azioni passate in corso'},
      usageExamples: {'en': ['I was working'], 'it': ['Stavo lavorando']},
      formationRules: {'en': 'Subject + was/were + verb-ing', 'it': 'Soggetto + was/were + verbo-ing'},
    );
  }

  static GrammarTense _getPresentPerfect() {
    return GrammarTense(
      id: 'present_perfect',
      name: 'Present Perfect',
      difficulty: 3,
      nameTranslations: {'en': 'Present Perfect', 'it': 'Presente Perfetto'},
      descriptions: {'en': 'For past actions with present relevance', 'it': 'Per azioni passate con rilevanza presente'},
      usageExamples: {'en': ['I have worked'], 'it': ['Ho lavorato']},
      formationRules: {'en': 'Subject + have/has + past participle', 'it': 'Soggetto + have/has + participio passato'},
    );
  }

  static GrammarTense _getFutureSimple() {
    return GrammarTense(
      id: 'future_simple',
      name: 'Future Simple',
      difficulty: 2,
      nameTranslations: {'en': 'Future Simple', 'it': 'Futuro Semplice'},
      descriptions: {'en': 'For future actions', 'it': 'Per azioni future'},
      usageExamples: {'en': ['I will work'], 'it': ['Lavorerò']},
      formationRules: {'en': 'Subject + will + base verb', 'it': 'Soggetto + will + verbo base'},
    );
  }

  static GrammarTense _getFirstConditional() {
    return GrammarTense(
      id: 'first_conditional',
      name: 'First Conditional',
      difficulty: 4,
      nameTranslations: {'en': 'First Conditional', 'it': 'Primo Condizionale'},
      descriptions: {'en': 'For real future possibilities', 'it': 'Per possibilità future reali'},
      usageExamples: {'en': ['If it rains, I will stay home'], 'it': ['Se piove, resterò a casa']},
      formationRules: {'en': 'If + present simple, will + base verb', 'it': 'If + presente semplice, will + verbo base'},
    );
  }

  static GrammarTense _getSecondConditional() {
    return GrammarTense(
      id: 'second_conditional',
      name: 'Second Conditional',
      difficulty: 5,
      nameTranslations: {'en': 'Second Conditional', 'it': 'Secondo Condizionale'},
      descriptions: {'en': 'For hypothetical situations', 'it': 'Per situazioni ipotetiche'},
      usageExamples: {'en': ['If I were rich, I would travel'], 'it': ['Se fossi ricco, viaggerei']},
      formationRules: {'en': 'If + past simple, would + base verb', 'it': 'If + passato semplice, would + verbo base'},
    );
  }
}