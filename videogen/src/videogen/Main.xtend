package videogen




class Main {
	def static void main(String[] args) {
		val vv=new transformModelToText()
//		Q1:
//		vv.transform()
//		Q2
		var playlist = vv.playlist()
		vv.transformationPlaylistToFileM3U(playlist)
//		Q4
		vv.transformationPlaylistToFileffmpeg(playlist)
//		Q5
//		Il faut calculer et inséré la durée de la vidéo dans la transformation
//	   	Q6
//		le model intermédiaire permet d'appliquer facilements des transformation de model suplémentaire ainsi que des transformations model to text tout en restant conforme a la grammaire du début
//		difficulté de maitrise de toutes les classes généré, et bien vérifier le nomage des variables lors de la création du fichier ecore.
//		Il faut spécifier le plus d'informations suplémentaire utilie le plus tot possible, come la durée des vidée qui doit pouvoir etre fourni si on veux ne pas avoir a la calculer.
//		Q7
//		Il a été necessaire de rajouter un attribut duration au MediaFile de Playlist
		
	
	
	
	}
	
}
