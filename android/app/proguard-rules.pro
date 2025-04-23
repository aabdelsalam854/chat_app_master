# احتفظ بـ KaraokeMediaHelper وكل ما يتعلق به
-keep class com.itgsa.opensdk.mediaunit.KaraokeMediaHelper { *; }
-keep class com.itgsa.opensdk.mediaunit.** { *; }
-keep class com.itgsa.opensdk.media.** { *; }

# احتفظ بكلاسات Java Beans التي تحتاجها مكتبة Jackson
-keep class java.beans.** { *; }

# احتفظ بكلاسات DOM المستخدمة من Jackson
-keep class org.w3c.dom.bootstrap.DOMImplementationRegistry { *; }

# احتفظ بكلاسات Jackson التي تتعامل مع DOM و Java7
-keep class com.fasterxml.jackson.databind.ext.** { *; }

# احتفظ بباقي مكتبات Jackson (اختياري لكن مفيد لو تستخدمها كثير)
-keep class com.fasterxml.jackson.annotation.** { *; }
-keep class com.fasterxml.jackson.core.** { *; }
-keep class com.fasterxml.jackson.databind.** { *; }

# احتفظ بكل الأنوتيشنز لأنها تستخدم أحيانًا مع JsonProperty أو ConstructorProperties
-keepattributes *Annotation*

# إضافي: حافظ على التواقيع التي قد تُستخدم لانعكاس الأنوتيشن
-keepattributes Signature
-keepattributes RuntimeVisibleAnnotations
-keepattributes RuntimeInvisibleAnnotations
-keep class **.zego.**  { *; }
-keep class **.**.zego_zpns.** { *; }
