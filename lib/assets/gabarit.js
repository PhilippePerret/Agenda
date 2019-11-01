/**
 * Méthode qui vérifie si un nouveau travail doit être annoncé
 */
let now = new Date().getTime();
// console.log("type de now (%d) : ", now, typeof now)
// now = parseInt(now,10);
// console.log("type de now (%d) après parseInt : ", now, typeof now);
// now = 1000 * now;
// console.log("type de now (%d) après * 1000 : ", now, typeof now);
const NOW = now;
console.log("TEMPS COURANT : %d", NOW);

class Travail {

  constructor(donnees){
    this.data = donnees;
    this.prepare();
  }

  prepare(){
    let my = this
    console.log("-> prepare « %s »", this.message);
    my.timer = setTimeout(my.show.bind(my), my.laps)
    console.log("<- fin de prepare « %s »", this.message);
  }

  show(){
    console.log("-> show « %s »", this.message);
    new Notification(this.message)
    this.kill_timer()
  }

  abort(){
    this.kill_timer()
    console.log("Le travail « »%s » a été aborté.", this.message)
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
const start_app = function(){
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
    console.log("Comparaison de %d >= %d et %d < %d", t, NOW, t, WEEK_END_TIME);
    if ( t >= NOW && t < WEEK_END_TIME ) {
      var data = TRIGGERS[t]
      data.time = t
      Object.assign(data, {laps: t - NOW})
      // On ajoute ce nouveau travail (en le déclenchant)
      CURRENT_WORKS.push(new Travail(data))
    }
  }
  console.log(CURRENT_WORKS);

}

Notification.requestPermission().then(function(result) {
  console.log(result);
  start_app();
});

window.addEventListener('beforeunload', ()=>{
  // Avant de quitter la page, il faut arrêter tous les timers
  for(travail of CURRENT_WORKS){
    travail.abort()
  }
  console.log("J'ai fait ça avant de quitter la page")
})
