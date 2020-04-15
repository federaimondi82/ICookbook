

///l'astrazione per il pattern GOF Proxy;
///implementato per una LazyResource(una ricetta leggera dal cloud firestore)
///o per una Recipe in locale
abstract class Resource{

  dynamic getResource();
}