/**
 * Méthode qui vérifie si un nouveau travail doit être annoncé
**/

const DAYS_NAME = ['dimanche','lundi','mardi','mercredi','jeudi','vendredi','samedi'];

let now = new Date().getTime();
// console.log("type de now (%d) : ", now, typeof now)
// now = parseInt(now,10);
// console.log("type de now (%d) après parseInt : ", now, typeof now);
// now = 1000 * now;
// console.log("type de now (%d) après * 1000 : ", now, typeof now);
const NOW = now;
// console.log("TEMPS COURANT : %d", NOW);

class Travail {

  constructor(donnees){
    this.data = donnees;
    this.prepare();
  }

  prepare(){
    let my = this
    // console.log("-> prepare « %s »", this.message);
    my.timer = setTimeout(my.show.bind(my), my.laps)
    // console.log("<- fin de prepare « %s »", this.message);
  }

  show(){
    // console.log("-> show « %s »", this.message);
    new Notification(this.message)
    this.kill_timer()
  }

  abort(){
    this.kill_timer()
    // console.log("Le travail « »%s » a été aborté.", this.message)
  }

  kill_timer(){
    clearTimeout(this.timer)
    delete this.timer
  }

  get time()    { return this.data.time }
  get laps()    { return this.data.laps }
  get message() { return this.data.message}
}

const CURRENT_WORKS = [] // calculés en fonction du temps courant

// True si la semaine affichée est la semaine courante
const IS_CURRENT_WEEK = NOW >= WEEK_START_TIME && NOW <= WEEK_END_TIME

const start_app = function(){

  /**
    On met en exergue le jour courant s'il appartient à la
    semaine affichée
  **/
  if (IS_CURRENT_WEEK){
    let today_indice = new Date().getUTCDay();
    let today_name = DAYS_NAME[today_indice];
    let colonne_jour = document.querySelector(`.jour.${today_name}`);
    colonne_jour.classList.add('exergue','current');
    // Visibilité ou non du CB pour n'afficher que le jour courant
    document.querySelector('#div-only-today').classList.remove('none');
  } else {
    console.log("La semaine affichée n'est pas la semaine courante.")
  }



  /**
    On va étudier les triggers à lancer
    La constante TRIGGERS contient un hash avec en clé le timestamp absolu
    (en millième de secondes) des travaux à exécuter.
    On passe en revue cette liste pour savoir si des travaux sont à exécuter
    dans la semaine affichée. Les temps de la semaine affichée sont définies
    par les constantes WEEK_START_TIME et WEEK_END_TIME
  **/
  for ( var t in TRIGGERS ) {
    t = parseInt(t)
    // console.log("Comparaison de %d >= %d et %d < %d", t, NOW, t, WEEK_END_TIME);
    if ( t >= NOW && t < WEEK_END_TIME ) {
      var data = TRIGGERS[t]
      data.time = t
      Object.assign(data, {laps: t - NOW})
      // On ajoute ce nouveau travail (en le déclenchant)
      CURRENT_WORKS.push(new Travail(data))
    }
  }
  // console.log(CURRENT_WORKS);

  /**
    Si le temps courant appartient à la semaine affichée, il faut
    gérer le curseur de temps (ligne rouge qui descend de minute
    en minute)
    Sinon, on le masque.
  **/
  if ( IS_CURRENT_WEEK ) {
    start_time_cursor();
  } else {
    mask_time_cursor();
  }
}

window.mask_time_cursor = function(){
  document.getElementById('time_cursor').style.display = "none";
}
window.start_time_cursor = function(){
  this.move_time_cursor();
  this.cursor_time_timer = setInterval(window.move_time_cursor.bind(window), 60*1000)
}
window.end_time_cursor = function(){
  clearInterval(this.cursor_time_timer)
  delete this.cursor_time_timer
}
const TOP_HOURS = 100;
window.move_time_cursor = function(){
  let cursor = document.getElementById('time_cursor');
  let curhour = document.querySelector('#time_cursor .current_hour');
  var hrs = new Date().getHours();
  var mns = new Date().getMinutes() + 1 ;
  if (mns > 59) { mns = 0; hrs += 1 }

  // // Pour les tests
  // hrs = 7; mns = 0;

  var top =  ((hrs - FIRST_DAY_HOUR) * 60) + mns + TOP_HOURS + 1 ;
  // console.log("top = %d ((%d - %d) * 60 + %d - %d)", top, hrs, FIRST_DAY_HOUR, mns, TOP_HOURS);
  cursor.style.top = `${top}px`;
  curhour.innerHTML = `${hrs}h${String(mns).padStart(2,'0')}`;
}


Notification.requestPermission().then(function(result) {
  console.log(result);
  start_app();
});

// // Pour que ça fonctionne aussi avec Safari
// TODO Mais attention : pour le moment, ça appelle l`e démarrage de l'application
// trop tôt, donc les colonnes ne sont pas encore définies et le programme
// foire en ne trouvant pas la colonne du jour. Solution : traiter un onready
// pour lancer `start_app()`
// function requestPermissionForNotification(){
//   if (Notification.permission === "granted") {
//     // console.log('allow', result);
//     console.log('allow');
//   start_app();
//     return true;
//   }
//   if (!Notification.requestPermission()) {
//   start_app();
//     return true;
//   }
//   Notification.requestPermission().then(function (result) {
//     if (result === 'denied') {
//       console.log('denied', result);
//   start_app();
//       return;
//     }
//     if (result === 'granted') {
//       console.log('allow', result);
//     }
//   })
// }
// requestPermissionForNotification()



window.addEventListener('beforeunload', ()=>{
  // Avant de quitter la page, il faut peut-être arrêter le
  // timer du curseur de temps
  if (window.cursor_time_timer) window.end_time_cursor()
  // Avant de quitter la page, il faut arrêter tous les timers
  for(travail of CURRENT_WORKS){
    travail.abort()
  }
  // console.log("J'ai fait ça avant de quitter la page")
})

// Méthode appelée par le CB qui permet de n'afficher que le jour
// courant
window.toggle_only_today = function(){
  var onlyToday = document.querySelector("#cb-only-today").checked === true;

  let visu = onlyToday ? 'hidden' : 'visible';
  document.querySelectorAll('.jour').forEach( o => o.style.visibility = visu)

  var jourToday = document.querySelector('.jour.current')
  jourToday.style.fontSize    = onlyToday ? '1.3em' : '1em';
  jourToday.style.visibility  = 'visible'; // toujours
  jourToday.style.width       = onlyToday ? '200%' : '';
  jourToday.style.backgroundColor = onlyToday ? 'white' : '';
}
