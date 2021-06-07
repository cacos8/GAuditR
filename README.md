# GAuditR
Script en R para documentar configuraciones de Google Analytics de forma rápida y automática

Antes de nada asegúrate de tener instalados los paquetes:
<ul>
 	<li><strong>googleAuthR</strong>: que controla que puedas acceder a tus datos</li>
 	<li><strong>openxlsx</strong>: para poder crear los ficheros Excel</li>
 	<li><strong>googleAnalyitcsR</strong>: para acceder a Google Analytics</li>
</ul>
El asunto está en que tienes que tener unos datos antes de ejecutarlo. Esos datos son:
<ul>
 	<li><strong>Id de cuenta de Google Analytics</strong>, que lo puedes coger de Google Analytics, apartado de administración --&gt;"Configuración de cuenta"</li>
</ul>
<img class="aligncenter wp-image-18899" src="https://analisis-web.es/wp-content/uploads/2021/06/iddecuenta.jpg" alt="id de cuenta de Google analyitcs" width="487" height="242" />
<ul>
 	<li>El identificador <strong>UA de propiedad</strong> que encontrarás también en administración, en propiedades "Configuración de la cuenta"</li>
</ul>
<img class="aligncenter wp-image-18900" src="https://analisis-web.es/wp-content/uploads/2021/06/iddepropiedad.jpg" alt="id depropiedad de Universal analytics" width="529" height="243" />

Esos dos números tendrás que introducirlos en el script justo dónde dice:
<pre style="padding-left: 120px;">cuenta_id&lt;-"&lt;INTRODUCE AQUÍ TU id DE CUENTA&gt;"
propiedad_id&lt;-"&lt;INTRODUCE AQUÍ TU UA de propiedad&gt;"</pre>
una vez introducidos esos cambios puedes ejecutar el script.

Para obtener tus ficheros Excel tendrás que <strong>llamar a la función "audita"</strong> de las siguiente forma:
<pre>audita (cuenta_id,propiedad_id)</pre>
A partir de ese momento empezará la magia y quedarán grabados en tu disco duro un conjunto de ficheros Excel. Uno por cada vista de la propiedad, con su nombre y fecha de creación.
