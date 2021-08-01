# Observaciones de mejora en aplicación
- La primera pantalla debería ser el login. De ahí el usuario debería elegir si es cliente, técnico o ambos (evaluar si podemos modificar eso)
- Usuario Cliente: sebastian.solar@presercomp.cl - A12345
  - Forzar el login a usar correos con minusculas.
  - Login:
    - Dar aviso cuando el usuario/clave no coinciden
    - Formulario de Registro: Omitir los botones "galería" y "cámara", y activar la acción de la foto al presionarl el ícono de la fotografía (cambiar la figura)
  - Panel: 
    - Íconos debe tener algun texto referencial para mejorar la UX
    - Estandarizar íconos (buscar una librería o invertir en un diseñador gráfico)
  - Navigation Drawer: 
    - Corregir despliegue de nombre y correo del usuario
    - Mi Perfil: No permite editar ni volver atrás
    - Noticias: Abre navegador. Ver la forma de mostrar las noticias internamente.
    - Atención al cliente: Idem al anterior.
    - Acerca de OneHand: Idem al anterior.
    - Compartir: No funciona
  - Solicitud:
    - Crear panel de solicitudes efectuadas.
- Usuario Técnico: sebastian.solar@szc.cl - A12345
  - Cambiar panel principal: Ofrecer de manera más visual, opciones más relevantes para el técnico (Número de tickets abiertos, Número de tickets cerrados, estadísticas de atención, Reputación *****)

# Observaciones de despliegue:
- Android: Funcionamiento relativamente normal
- iOS    : No se genera app por error con Firebase (https://medium.com/@ryanwaldorf/how-to-setup-flutter-with-firebase-for-ios-791f0710707e [https://medium.com/@ryanwaldorf/how-to-setup-flutter-with-firebase-for-ios-791f0710707e])