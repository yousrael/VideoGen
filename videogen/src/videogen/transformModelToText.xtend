package videogen

import java.util.HashMap
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl
import org.junit.Test
import org.xtext.example.mydsl.VideoGenStandaloneSetupGenerated
import org.xtext.example.mydsl.videoGen.AlternativeVideoSeq
import org.xtext.example.mydsl.videoGen.MandatoryVideoSeq
import org.xtext.example.mydsl.videoGen.OptionalVideoSeq
import org.xtext.example.mydsl.videoGen.VideoGeneratorModel

import static org.junit.Assert.*

import java.util.ArrayList
import java.io.PrintWriter
import java.util.Random
import playlist.PlaylistFactory

import playlist.Playlist
import java.io.BufferedReader
import java.io.InputStreamReader

class transformModelToText {
	def loadVideoGenerator(URI uri) {
		new VideoGenStandaloneSetupGenerated().createInjectorAndDoEMFRegistration()
		var res = new ResourceSetImpl().getResource(uri, true);
		res.contents.get(0) as VideoGeneratorModel
	}
//	Q1
	def transform(){
	var videoGen = loadVideoGenerator(URI.createURI("foo1.videogen")) 
     val writer=new PrintWriter("/home/yousra/workspaceIDM/VideoGen/videogen/src/videogen/videogenresult.txt","UTF-8")
	  val random=new Random()
	  random.nextInt(101)	
				// writer.println(random.nextInt(101))	
		
		videoGen.videoseqs.forEach[videoseq |
			if (videoseq instanceof MandatoryVideoSeq) {
				val desc = (videoseq as MandatoryVideoSeq).description.location
				 writer.println("file"+" "+"'"+desc+"'"+"\n")				
			}
			else if (videoseq instanceof OptionalVideoSeq) {
				val desc = (videoseq as OptionalVideoSeq).description.location
				//println("proba optional "+(videoseq as OptionalVideoSeq).description.probability);
			     var proba=random.nextInt(1)
				//if((videoseq as OptionalVideoSeq).description.probability == 0)
					//(videoseq as OptionalVideoSeq).description.probability = 50
				if(proba==1)
				 	writer.println("file"+" "+"'"+desc+"'"+"\n")	
				 	println("proba "+desc+" "+proba)
			}
			else {
				val altvid = (videoseq as AlternativeVideoSeq)
				var l = new ArrayList()
				var proba = random.nextInt(altvid.videodescs.size)
				val vaa=altvid.videodescs.get(proba)
				//var cumulproba = 100
				
					 writer.println("file"+" "+"'"+vaa.location+"'"+"\n")		
				}
			
		]
	
	  
		
		writer.close()
			
		
		
	}
	
	static var i = 0;
	
	
	
	def genID() {
		"v" + i++
	}
//	Q3
	def playlist(){
		val playlist = PlaylistFactory.eINSTANCE.createPlaylist;
		
		var videoGen = loadVideoGenerator(URI.createURI("foo1.videogen")) 
	  val random=new Random()
	  
	  videoGen.videoseqs.forEach[videoseq |
			if (videoseq instanceof MandatoryVideoSeq) {
				val desc = (videoseq as MandatoryVideoSeq).description.location
				var MF = PlaylistFactory.eINSTANCE.createMediaFile()
				MF.location = desc
				playlist.videos.add(MF)
			}
			else if (videoseq instanceof OptionalVideoSeq) {
				val desc = (videoseq as OptionalVideoSeq).description.location
			     var proba=random.nextInt(1)
				if(proba==1){
				 	var MF = PlaylistFactory.eINSTANCE.createMediaFile()
					MF.location = desc
					playlist.videos.add(MF)
				}
			}
			else {
				val altvid = (videoseq as AlternativeVideoSeq)
				var l = new ArrayList()
				var proba = random.nextInt(altvid.videodescs.size)
				val vaa=altvid.videodescs.get(proba)
				var MF = PlaylistFactory.eINSTANCE.createMediaFile()
					MF.location = vaa.location
					playlist.videos.add(MF)
				}
			
		]
		playlist
		// la dernière instruction est un return
	}
	//Q3
	def transformationPlaylistToFileM3U(Playlist playlist){
		//ecrire dans un fichier
		val writer=new PrintWriter("result.m3u")
		for(element : playlist.videos)
			writer.write(element.location+"\n")
			
		writer.close()
	}
	//Q4
	def transformationPlaylistToFileffmpeg(Playlist playlist){
		//ecrire dans un fichier
		val writer=new PrintWriter("result.ffmpeg")
		for(element : playlist.videos)
			writer.write("file "+element.location+"\n")
			
		writer.close()
	}
	//Q5-Q8
	def transformationPlaylistToFileM3UEtendu(Playlist playlist){
		//ecrire dans un fichier
		val writer=new PrintWriter("resultEtendu.m3u")
		writer.write("#EXTM3U \n")
		
		for(element : playlist.videos)
			writer.write("#EXT-X-DISCONTINUITY"+" \n"+" #EXTINF :"+element.duration+"\n" +element.location+"\n")
		writer.write("#EXT-X-ENDLIST")	
		writer.close()
	}
	//Q7-1
	def transformAjoutDuree(){
	var videoGen = loadVideoGenerator(URI.createURI("foo1.videogen")) 
  
	  val random=new Random()
	  random.nextInt(101)	
				// writer.println(random.nextInt(101))	
		
		videoGen.videoseqs.forEach[videoseq |
			if (videoseq instanceof MandatoryVideoSeq) {
				val desc = (videoseq as MandatoryVideoSeq).description.location
				var duree=(videoseq as MandatoryVideoSeq).description.duration
				 duree=calculDuree(desc).intValue()
				
	             			
			}
			else if (videoseq instanceof OptionalVideoSeq) {
				val desc = (videoseq as OptionalVideoSeq).description.location
				calculDuree(desc)
				//println("proba optional "+(videoseq as OptionalVideoSeq).description.probability);
			     var proba=random.nextInt(1)
				//if((videoseq as OptionalVideoSeq).description.probability == 0)
					//(videoseq as OptionalVideoSeq).description.probability = 50
				
			}
			else {
				val altvid = (videoseq as AlternativeVideoSeq)
				var l = new ArrayList()
				var proba = random.nextInt(altvid.videodescs.size)
				val vaa=altvid.videodescs.get(proba)
				//var cumulproba = 100
				
					 	
				}
			
		]
			
		
	}
	//Q7-2
	def playlistWithDuration(){
		val playlist = PlaylistFactory.eINSTANCE.createPlaylist;
		
		var videoGen = loadVideoGenerator(URI.createURI("foo1.videogen")) 
	  val random=new Random()
	  
	  videoGen.videoseqs.forEach[videoseq |
			if (videoseq instanceof MandatoryVideoSeq) {
				val desc = (videoseq as MandatoryVideoSeq).description.location
					var duree=(videoseq as MandatoryVideoSeq).description.duration
				 duree=calculDuree(desc).intValue()
				var MF = PlaylistFactory.eINSTANCE.createMediaFile()
				MF.location = desc
				MF.duration=duree
				playlist.videos.add(MF)
			}
			else if (videoseq instanceof OptionalVideoSeq) {
				val desc = (videoseq as OptionalVideoSeq).description.location
				 var duree=(videoseq as MandatoryVideoSeq).description.duration
				 duree=calculDuree(desc).intValue()
			     var proba=random.nextInt(1)
				if(proba==1){
				 	var MF = PlaylistFactory.eINSTANCE.createMediaFile()
					MF.location = desc
					MF.duration=duree
					playlist.videos.add(MF)
				}
			}
			else {
				val altvid = (videoseq as AlternativeVideoSeq)
				var l = new ArrayList()
				var proba = random.nextInt(altvid.videodescs.size)
				val vaa=altvid.videodescs.get(proba)
				 var duree=(videoseq as MandatoryVideoSeq).description.duration
				
				var MF = PlaylistFactory.eINSTANCE.createMediaFile()
				 duree=calculDuree(vaa.location).intValue()
				 MF.location = vaa.location
				 MF.duration=duree
					playlist.videos.add(MF)
				}
			
		]
		playlist
		// la dernière instruction est un return
	}
	//Q7
	def calculDuree(String videoLocation){
		println("duration : "+videoLocation)
		var cmd = "/usr/local/bin/ffprobe -v error -select_streams v:0 -show_entries stream=duration -of default=noprint_wrappers=1:nokey=1 -i " +videoLocation 
		var p =Runtime.runtime.exec(cmd)
		var reader= new BufferedReader(new InputStreamReader(p.inputStream))
		var line=0.0
	      line =Double.parseDouble(reader.readLine())
	      line
		
	}
	//Q9
	def creationVignette(String videoLocation,int tempsCapture,String chemin){
		println("vignette : "+videoLocation +" to "+chemin+ " at "+tempsCapture+"s") 
    	var p1 =Runtime.runtime.exec("pwd")
		var reader1= new BufferedReader(new InputStreamReader(p1.inputStream))
		var pwd = reader1.readLine()
		var cmd = "ffmpeg -y -i "+pwd+"/"+videoLocation+ " -r 1 -t 00:00:01 -ss 00:00:"+tempsCapture+ " "+pwd+"/"+chemin 
		var p =Runtime.runtime.exec(cmd)
	}
	//Q9
	def playlistVignette(Playlist playlist){
		//ecrire dans un fichier
		
		for(element : playlist.videos)
		creationVignette(element.location,1,element.location+".png")
	}
	//Q10
	def void printToHTML(VideoGeneratorModel videoGen) {
		//var numSeq = 1
		println("<ul>")
		videoGen.videoseqs.forEach[videoseq | 
			if (videoseq instanceof MandatoryVideoSeq) {
				val desc = (videoseq as MandatoryVideoSeq).description.location
				  creationVignette(desc,1,desc+".png")
				  println ("<li>" +"<img src="+desc+".png/></li>")  				
			}
			else if (videoseq instanceof OptionalVideoSeq) {
				val desc = (videoseq as OptionalVideoSeq).description.location
				
					creationVignette(desc,1,desc+".png")
				  println ("<li>" +"<img src="+desc+".png/></li>")  
			}
			else {
				val altvid = (videoseq as AlternativeVideoSeq)
	
					
				if (altvid.videodescs.size > 0) // there are vid seq alternatives
					println ("<ul>")
				for (vdesc : altvid.videodescs) {
					creationVignette(vdesc.location,1,vdesc.location+".png")
				  println ("<li>" +"<img src="+vdesc.location+".png/></li>")  
				}
				if (altvid.videodescs.size > 0) // there are vid seq alternatives
					println ("</ul>")
			}
		]
		println("</ul>")
}
//Q11
def verify(){
	var videoGen = loadVideoGenerator(URI.createURI("foo1.videogen")) 
   val random=new Random()
	  random.nextInt(101)
	  var idOp=""
	  var idAl=""
	  var idM=""
	 // val idM=1	
				// writer.println(random.nextInt(101))	
		
		for(videoseq :videoGen.videoseqs){
			if (videoseq instanceof MandatoryVideoSeq) {
			idM = (videoseq as MandatoryVideoSeq).description.videoid
				 if(idM.isNullOrEmpty) idM = genID()
							
			}
			else if (videoseq instanceof OptionalVideoSeq) {
				val probabilite = (videoseq as OptionalVideoSeq).description.probability
				//println("proba optional "+(videoseq as OptionalVideoSeq).description.probability);
			    
				 	 idOp=(videoseq as OptionalVideoSeq).description.videoid
				 	  if(idOp.isNullOrEmpty) idOp = genID()
				 	  if(probabilite>100)
				 	  throw new Exception()
				 	 
			
			
			}
			else {
			
				var totalProb=0
				val altvid = (videoseq as AlternativeVideoSeq)
		       for (vdesc : altvid.videodescs) {
				 idAl= vdesc.videoid
				 val probabilite=vdesc.probability
				  if(idAl.isNullOrEmpty) idAl = genID()
				  if(idAl==idOp || idAl==idM || idM==idOp)
				  	throw new Exception()
				  
				 totalProb+=probabilite
				}
				if(totalProb>1)
				throw new Exception()
				
			
		}
	
	  
		
		
			
		
		
	}
	}
	
}