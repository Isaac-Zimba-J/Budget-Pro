; ModuleID = 'marshal_methods.armeabi-v7a.ll'
source_filename = "marshal_methods.armeabi-v7a.ll"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "armv7-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [340 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [1020 x i32] [
	i32 u0x0027eb9e, ; 0: System.Net.NetworkInformation.dll => 69
	i32 u0x00345a11, ; 1: lib_System.Net.Requests.dll.so => 73
	i32 u0x005332a8, ; 2: lib_Xamarin.AndroidX.Legacy.Support.Core.Utils.dll.so => 250
	i32 u0x009b21bb, ; 3: System.Net.NameResolution.dll => 68
	i32 u0x00c8cc5d, ; 4: lib_Xamarin.AndroidX.Loader.dll.so => 265
	i32 u0x00e0bbf7, ; 5: lib_System.Xml.XmlSerializer.dll.so => 163
	i32 u0x00efe298, ; 6: System.Runtime.Intrinsics.dll => 109
	i32 u0x0119bc86, ; 7: lib_Microsoft.Extensions.DependencyInjection.Abstractions.dll.so => 199
	i32 u0x014f0aa4, ; 8: lib_Grpc.Auth.dll.so => 191
	i32 u0x01f2c4e1, ; 9: Xamarin.AndroidX.Lifecycle.Runtime => 257
	i32 u0x0211b5dc, ; 10: Xamarin.Google.Guava.ListenableFuture.dll => 294
	i32 u0x02139ac3, ; 11: System.IO.FileSystem.DriveInfo => 48
	i32 u0x0254c520, ; 12: Newtonsoft.Json.dll => 210
	i32 u0x025a8054, ; 13: System.Net.WebSockets.dll => 81
	i32 u0x02664405, ; 14: lib-uk-Microsoft.Maui.Controls.resources.dll.so => 334
	i32 u0x028aa24d, ; 15: System.Threading.Thread => 146
	i32 u0x02bda0f5, ; 16: Xamarin.KotlinX.AtomicFU.Jvm => 298
	i32 u0x03358480, ; 17: lib_Microsoft.Maui.dll.so => 207
	i32 u0x0335cdbc, ; 18: ca/Microsoft.Maui.Controls.resources => 306
	i32 u0x03f75868, ; 19: System.Diagnostics.StackTrace => 30
	i32 u0x0410f24b, ; 20: System.Security.Cryptography.Primitives => 125
	i32 u0x044bb714, ; 21: Microsoft.Maui.Graphics.dll => 209
	i32 u0x04886f5b, ; 22: lib_Google.Api.CommonProtos.dll.so => 179
	i32 u0x04e7b0a1, ; 23: System.Runtime.CompilerServices.VisualC.dll => 103
	i32 u0x056606a6, ; 24: lib_System.Collections.NonGeneric.dll.so => 10
	i32 u0x060d4943, ; 25: Xamarin.AndroidX.SlidingPaneLayout => 278
	i32 u0x065dd880, ; 26: lib_System.Linq.Queryable.dll.so => 61
	i32 u0x06c2cd46, ; 27: zh-HK/Microsoft.Maui.Controls.resources => 336
	i32 u0x06e4e181, ; 28: lib_Xamarin.Google.Guava.ListenableFuture.dll.so => 294
	i32 u0x06ee56d3, ; 29: lib_System.Net.Mail.dll.so => 67
	i32 u0x06ffddbc, ; 30: System.Runtime.InteropServices => 108
	i32 u0x072f9521, ; 31: Xamarin.AndroidX.SlidingPaneLayout.dll => 278
	i32 u0x074aea82, ; 32: System.Threading.Channels.dll => 140
	i32 u0x0772c6a7, ; 33: lib_System.Diagnostics.TextWriterTraceListener.dll.so => 31
	i32 u0x0881c32f, ; 34: System.Net.WebHeaderCollection => 78
	i32 u0x08f064cf, ; 35: System.Security.Cryptography.Primitives.dll => 125
	i32 u0x097ed3c0, ; 36: System.ComponentModel.Annotations => 13
	i32 u0x098905a2, ; 37: lib_Xamarin.AndroidX.Concurrent.Futures.dll.so => 232
	i32 u0x09d975c3, ; 38: Xamarin.AndroidX.Collection.dll => 229
	i32 u0x09e60a6e, ; 39: Xamarin.KotlinX.AtomicFU.dll => 297
	i32 u0x09ea3403, ; 40: lib_Google.Cloud.Firestore.V1.dll.so => 186
	i32 u0x0a0c2bd0, ; 41: lib_Xamarin.AndroidX.Activity.dll.so => 218
	i32 u0x0a81994f, ; 42: System.ServiceProcess => 133
	i32 u0x0ade3a75, ; 43: Xamarin.AndroidX.SwipeRefreshLayout.dll => 280
	i32 u0x0ae43932, ; 44: lib_Xamarin.AndroidX.Tracing.Tracing.dll.so => 281
	i32 u0x0aee6a3d, ; 45: lib-vi-Microsoft.Maui.Controls.resources.dll.so => 335
	i32 u0x0aeedc53, ; 46: lib_Xamarin.Google.Android.Material.dll.so => 290
	i32 u0x0afca281, ; 47: System.ValueTuple.dll => 152
	i32 u0x0b0de1c3, ; 48: lib_System.Xml.XPath.XDocument.dll.so => 160
	i32 u0x0b63b1e1, ; 49: lib_System.Net.Http.Json.dll.so => 64
	i32 u0x0b721a36, ; 50: lib-pl-Microsoft.Maui.Controls.resources.dll.so => 325
	i32 u0x0ba65f85, ; 51: vi/Microsoft.Maui.Controls.resources.dll => 335
	i32 u0x0ba8e231, ; 52: lib_System.Net.ServicePoint.dll.so => 75
	i32 u0x0be195c3, ; 53: zh-HK/Microsoft.Maui.Controls.resources.dll => 336
	i32 u0x0c38ff48, ; 54: System.ComponentModel => 18
	i32 u0x0c7b2e71, ; 55: Xamarin.AndroidX.Browser.dll => 227
	i32 u0x0cfa66a6, ; 56: lib_System.IO.Compression.FileSystem.dll.so => 44
	i32 u0x0d1f8edb, ; 57: System.Diagnostics.Debug => 26
	i32 u0x0d73bff4, ; 58: lib_Microsoft.Extensions.Logging.Debug.dll.so => 202
	i32 u0x0db8d509, ; 59: Xamarin.AndroidX.Legacy.Support.Core.Utils.dll => 250
	i32 u0x0dc10265, ; 60: Microsoft.CSharp.dll => 1
	i32 u0x0dc2f416, ; 61: lib_Xamarin.AndroidX.CustomView.dll.so => 239
	i32 u0x0dcb05c4, ; 62: System.Linq.Parallel => 60
	i32 u0x0dd133ce, ; 63: System.Globalization => 42
	i32 u0x0e762ada, ; 64: lib-nb-Microsoft.Maui.Controls.resources.dll.so => 323
	i32 u0x0eb2f8c5, ; 65: System.Reflection.Emit.Lightweight => 92
	i32 u0x0ec71be0, ; 66: lib_System.Security.SecureString.dll.so => 130
	i32 u0x0ecfdca9, ; 67: lib_Xamarin.Android.Glide.dll.so => 214
	i32 u0x0f99119d, ; 68: Xamarin.AndroidX.ConstraintLayout.dll => 233
	i32 u0x107abf20, ; 69: System.Threading.Timer.dll => 148
	i32 u0x109c6ab8, ; 70: Xamarin.AndroidX.Lifecycle.LiveData.dll => 253
	i32 u0x10b7d2b7, ; 71: Xamarin.AndroidX.Interpolator => 249
	i32 u0x10bf9929, ; 72: cs/Microsoft.Maui.Controls.resources.dll => 307
	i32 u0x10c1d9f6, ; 73: lib_System.Data.DataSetExtensions.dll.so => 23
	i32 u0x113d3381, ; 74: lib-sk-Microsoft.Maui.Controls.resources.dll.so => 330
	i32 u0x1159791e, ; 75: System.IO.Pipes.AccessControl.dll => 55
	i32 u0x11d123fd, ; 76: System.Net.Ping.dll => 70
	i32 u0x13031348, ; 77: Xamarin.AndroidX.Activity.dll => 218
	i32 u0x132b30dd, ; 78: System.Numerics => 84
	i32 u0x1331a702, ; 79: lib_Xamarin.Google.Crypto.Tink.Android.dll.so => 292
	i32 u0x136bf828, ; 80: lib_System.Runtime.dll.so => 117
	i32 u0x14095832, ; 81: ja/Microsoft.Maui.Controls.resources.dll => 320
	i32 u0x146817a2, ; 82: Xamarin.AndroidX.Lifecycle.Common => 251
	i32 u0x14eaf2a7, ; 83: lib_System.ComponentModel.Annotations.dll.so => 13
	i32 u0x153e1455, ; 84: it/Microsoft.Maui.Controls.resources.dll => 319
	i32 u0x15502fa0, ; 85: cs/Microsoft.Maui.Controls.resources => 307
	i32 u0x15766b7b, ; 86: System.ServiceModel.Web => 132
	i32 u0x15c0ca6d, ; 87: Grpc.Net.Common => 194
	i32 u0x15c177ae, ; 88: lib_Microsoft.Extensions.Configuration.dll.so => 196
	i32 u0x15e184df, ; 89: lib_System.Runtime.Loader.dll.so => 110
	i32 u0x15ebe147, ; 90: System.IO.Pipes => 56
	i32 u0x1621b0b0, ; 91: Grpc.Core.Api.dll => 192
	i32 u0x1658bf94, ; 92: System.Transactions.Local => 150
	i32 u0x16646418, ; 93: System.Net.ServicePoint.dll => 75
	i32 u0x16a510e1, ; 94: System.Threading.Thread.dll => 146
	i32 u0x16fe439a, ; 95: System.Memory.dll => 63
	i32 u0x175bb51e, ; 96: Grpc.Net.Client.dll => 193
	i32 u0x1766c1f7, ; 97: System.Threading.ThreadPool.dll => 147
	i32 u0x1778984a, ; 98: lib_Xamarin.AndroidX.ResourceInspection.Annotation.dll.so => 274
	i32 u0x17969339, ; 99: _Microsoft.Android.Resource.Designer => 339
	i32 u0x180c08d0, ; 100: WindowsBase => 166
	i32 u0x195d1904, ; 101: Xamarin.AndroidX.Lifecycle.Runtime.Android => 258
	i32 u0x198cd3eb, ; 102: lib_System.Security.Cryptography.Encoding.dll.so => 123
	i32 u0x19f6996b, ; 103: sv/Microsoft.Maui.Controls.resources.dll => 331
	i32 u0x1a4e3ec4, ; 104: Xamarin.AndroidX.ConstraintLayout.Core => 234
	i32 u0x1a61054f, ; 105: System.Collections => 12
	i32 u0x1ae0ec2c, ; 106: Xamarin.AndroidX.Fragment.dll => 247
	i32 u0x1ae969b2, ; 107: System.Security.Cryptography.X509Certificates => 126
	i32 u0x1b317bfd, ; 108: System.Web.HttpUtility.dll => 153
	i32 u0x1b46a9fd, ; 109: lib_Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll.so => 259
	i32 u0x1b5932ea, ; 110: lib_Mono.Android.Runtime.dll.so => 171
	i32 u0x1b611806, ; 111: System.Runtime.Serialization.Primitives.dll => 114
	i32 u0x1bc4415d, ; 112: mscorlib => 167
	i32 u0x1bc6ffe7, ; 113: lib_Java.Interop.dll.so => 169
	i32 u0x1bcdaf18, ; 114: lib_Xamarin.AndroidX.LocalBroadcastManager.dll.so => 266
	i32 u0x1bff388e, ; 115: System.dll => 165
	i32 u0x1c690cb9, ; 116: Xamarin.AndroidX.Interpolator.dll => 249
	i32 u0x1c78d08a, ; 117: lib_System.Private.Uri.dll.so => 87
	i32 u0x1d05f80c, ; 118: Xamarin.AndroidX.LocalBroadcastManager.dll => 266
	i32 u0x1d48410e, ; 119: lib_Xamarin.AndroidX.SlidingPaneLayout.dll.so => 278
	i32 u0x1d4d8185, ; 120: lib_System.Runtime.Serialization.dll.so => 116
	i32 u0x1dbae811, ; 121: System.ObjectModel => 85
	i32 u0x1dd2dc50, ; 122: id/Microsoft.Maui.Controls.resources.dll => 318
	i32 u0x1e092f31, ; 123: fi/Microsoft.Maui.Controls.resources.dll => 312
	i32 u0x1e6ff77b, ; 124: lib_Google.Api.Gax.dll.so => 180
	i32 u0x1e9789de, ; 125: Microsoft.Extensions.Primitives.dll => 204
	i32 u0x1f1dceb7, ; 126: lib_System.Security.Cryptography.Primitives.dll.so => 125
	i32 u0x1f443e2d, ; 127: lib_System.AppContext.dll.so => 6
	i32 u0x1f6088c2, ; 128: System.Transactions.dll => 151
	i32 u0x1f6bf43d, ; 129: hi/Microsoft.Maui.Controls.resources => 315
	i32 u0x1f9b4faa, ; 130: System.Linq.Queryable => 61
	i32 u0x20216150, ; 131: Microsoft.Extensions.Logging => 200
	i32 u0x20303736, ; 132: System.IO.FileSystem.dll => 51
	i32 u0x2080b118, ; 133: System.Runtime.Extensions => 104
	i32 u0x20924146, ; 134: System.Runtime.Serialization.Xml => 115
	i32 u0x20b7cdc6, ; 135: Microsoft.Bcl.AsyncInterfaces => 195
	i32 u0x20bbb280, ; 136: System.Globalization.Calendars => 40
	i32 u0x213954e7, ; 137: Jsr305Binding => 291
	i32 u0x21f36ef8, ; 138: Xamarin.AndroidX.Window.Extensions.Core.Core => 289
	i32 u0x22697083, ; 139: System.Security.Cryptography.Cng => 121
	i32 u0x22f7dd28, ; 140: lib_Microsoft.Bcl.AsyncInterfaces.dll.so => 195
	i32 u0x234b6fb2, ; 141: pt-BR/Microsoft.Maui.Controls.resources.dll => 326
	i32 u0x236793de, ; 142: lib_GoogleGson.dll.so => 190
	i32 u0x2386616a, ; 143: lib_System.ServiceModel.Web.dll.so => 132
	i32 u0x2397454a, ; 144: lib_System.Collections.Specialized.dll.so => 11
	i32 u0x239cf51b, ; 145: CommunityToolkit.Maui => 174
	i32 u0x23d83352, ; 146: System.IO.IsolatedStorage.dll => 52
	i32 u0x23eaab34, ; 147: lib_System.Core.dll.so => 21
	i32 u0x24154ecb, ; 148: System.IO.Compression.FileSystem => 44
	i32 u0x2459aaf0, ; 149: lib_System.Net.Sockets.dll.so => 76
	i32 u0x2493d7b9, ; 150: System.Security.Cryptography.Algorithms => 120
	i32 u0x2512d1c5, ; 151: Xamarin.AndroidX.Lifecycle.Runtime.Android.dll => 258
	i32 u0x2568904f, ; 152: Xamarin.AndroidX.CustomView => 239
	i32 u0x26233b86, ; 153: Xamarin.AndroidX.Emoji2.ViewsHelper.dll => 245
	i32 u0x26249f17, ; 154: lib_Xamarin.AndroidX.CustomView.PoolingContainer.dll.so => 240
	i32 u0x262968a7, ; 155: lib_System.Reflection.Extensions.dll.so => 94
	i32 u0x262d781c, ; 156: lib-de-Microsoft.Maui.Controls.resources.dll.so => 309
	i32 u0x2645b6c3, ; 157: lib_CommunityToolkit.Maui.Core.dll.so => 175
	i32 u0x2660a755, ; 158: System.Net => 82
	i32 u0x269049d8, ; 159: Google.Cloud.Firestore.V1.dll => 186
	i32 u0x27077a14, ; 160: lib_Google.Apis.Core.dll.so => 184
	i32 u0x27787397, ; 161: System.Text.Encodings.Web.dll => 137
	i32 u0x278c7790, ; 162: Xamarin.AndroidX.VersionedParcelable => 285
	i32 u0x27b53050, ; 163: lib_System.Data.Common.dll.so => 22
	i32 u0x27b6d01f, ; 164: Xamarin.AndroidX.Arch.Core.Common.dll => 225
	i32 u0x2814a96c, ; 165: System.Collections.Concurrent => 8
	i32 u0x282acf5e, ; 166: lib_System.IO.FileSystem.dll.so => 51
	i32 u0x28607aa1, ; 167: lib-pt-BR-Microsoft.Maui.Controls.resources.dll.so => 326
	i32 u0x287c1a88, ; 168: Xamarin.KotlinX.AtomicFU => 297
	i32 u0x28bdabca, ; 169: System.Net.Security => 74
	i32 u0x2904cf94, ; 170: ca/Microsoft.Maui.Controls.resources.dll => 306
	i32 u0x29293ff5, ; 171: System.Xml.Linq.dll => 156
	i32 u0x29352520, ; 172: Xamarin.KotlinX.Coroutines.Android.dll => 299
	i32 u0x29423679, ; 173: lib_Xamarin.AndroidX.CursorAdapter.dll.so => 238
	i32 u0x295a9e3d, ; 174: System.Windows => 155
	i32 u0x296c7566, ; 175: lib_System.Xml.dll.so => 164
	i32 u0x29af2b3b, ; 176: System.Reflection.Emit => 93
	i32 u0x29bd7e5b, ; 177: Xamarin.Jetbrains.Annotations => 295
	i32 u0x29be9df3, ; 178: System.IO.Compression.ZipFile => 45
	i32 u0x2a1e8ecb, ; 179: ko/Microsoft.Maui.Controls.resources.dll => 321
	i32 u0x2a4afd4a, ; 180: de/Microsoft.Maui.Controls.resources.dll => 309
	i32 u0x2b15ed29, ; 181: System.Runtime.Loader.dll => 110
	i32 u0x2ba1ca8c, ; 182: lib_System.Security.dll.so => 131
	i32 u0x2bb094cb, ; 183: lib_Firebase.Auth.dll.so => 178
	i32 u0x2bd14e96, ; 184: System.Security.SecureString.dll => 130
	i32 u0x2ccb552d, ; 185: lib_Google.Api.Gax.Grpc.dll.so => 181
	i32 u0x2cd6293c, ; 186: System.Diagnostics.Contracts.dll => 25
	i32 u0x2d052d0c, ; 187: Xamarin.Android.Glide.Annotations.dll => 215
	i32 u0x2d322560, ; 188: lib_System.Xml.XmlDocument.dll.so => 162
	i32 u0x2d445acd, ; 189: System.Net.Requests => 73
	i32 u0x2d745423, ; 190: System.IO.Pipes.dll => 56
	i32 u0x2e394f87, ; 191: System.IO.Compression => 46
	i32 u0x2eec5558, ; 192: lib_System.Reflection.dll.so => 98
	i32 u0x2f0980eb, ; 193: Microsoft.Extensions.Options => 203
	i32 u0x2f0fe5eb, ; 194: lib_System.Reflection.DispatchProxy.dll.so => 90
	i32 u0x2f1c1e69, ; 195: Xamarin.AndroidX.CustomView.PoolingContainer.dll => 240
	i32 u0x2ff6fb9f, ; 196: System.Data.Common => 22
	i32 u0x302809e9, ; 197: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll => 255
	i32 u0x30a0e95c, ; 198: lib_System.Threading.Thread.dll.so => 146
	i32 u0x311247b5, ; 199: System.Private.Uri.dll => 87
	i32 u0x317d5b75, ; 200: System.IO.Compression.Brotli => 43
	i32 u0x31a103c6, ; 201: System.Xml.XPath.dll => 161
	i32 u0x31b69d60, ; 202: System.Net.Quic => 72
	i32 u0x3246f6cd, ; 203: Xamarin.AndroidX.Print => 271
	i32 u0x3312831d, ; 204: lib_Xamarin.AndroidX.DrawerLayout.dll.so => 242
	i32 u0x33e88be1, ; 205: ar/Microsoft.Maui.Controls.resources => 305
	i32 u0x340ac0b8, ; 206: Microsoft.VisualBasic => 3
	i32 u0x34505120, ; 207: System.Globalization.dll => 42
	i32 u0x3463c971, ; 208: System.Net.Http.Json => 64
	i32 u0x34a66c56, ; 209: lib_System.IO.Pipes.dll.so => 56
	i32 u0x352e5794, ; 210: lib_Xamarin.Google.ErrorProne.Annotations.dll.so => 293
	i32 u0x35e25008, ; 211: System.ComponentModel.Primitives.dll => 16
	i32 u0x3612ff2c, ; 212: lib_System.IO.dll.so => 58
	i32 u0x364e69a3, ; 213: System.IO.MemoryMappedFiles.dll => 53
	i32 u0x36e9595b, ; 214: lib_System.Transactions.dll.so => 151
	i32 u0x370eff4f, ; 215: lib_System.Globalization.Extensions.dll.so => 41
	i32 u0x373f6a31, ; 216: tr/Microsoft.Maui.Controls.resources.dll => 333
	i32 u0x3751ef41, ; 217: Xamarin.Google.Guava.ListenableFuture => 294
	i32 u0x3787b992, ; 218: lib_System.ComponentModel.DataAnnotations.dll.so => 14
	i32 u0x37ea9cd7, ; 219: lib_Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so => 262
	i32 u0x382704bd, ; 220: lib_Xamarin.AndroidX.Emoji2.ViewsHelper.dll.so => 245
	i32 u0x387ab9ee, ; 221: lib_System.Management.dll.so => 213
	i32 u0x38c136f7, ; 222: System.Runtime.InteropServices.JavaScript.dll => 106
	i32 u0x38d89c1d, ; 223: lib_Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so => 252
	i32 u0x38f24a24, ; 224: Newtonsoft.Json => 210
	i32 u0x39481653, ; 225: lib_mscorlib.dll.so => 167
	i32 u0x399f1f06, ; 226: Xamarin.Google.Crypto.Tink.Android => 292
	i32 u0x39adca5e, ; 227: Xamarin.AndroidX.Lifecycle.Common.dll => 251
	i32 u0x3a20ecf3, ; 228: System.Diagnostics.Tracing => 34
	i32 u0x3a2aaa1d, ; 229: System.Xml.XDocument => 159
	i32 u0x3a8b0a79, ; 230: lib_Xamarin.KotlinX.Coroutines.Android.dll.so => 299
	i32 u0x3acd0267, ; 231: System.Private.DataContractSerialization.dll => 86
	i32 u0x3ad7b407, ; 232: System.Diagnostics.Tools => 32
	i32 u0x3b008d80, ; 233: lib_Xamarin.AndroidX.DynamicAnimation.dll.so => 243
	i32 u0x3b2c715c, ; 234: System.Collections.dll => 12
	i32 u0x3b3271e4, ; 235: zh-Hans/Microsoft.Maui.Controls.resources => 337
	i32 u0x3b458447, ; 236: lib_System.Threading.Tasks.Dataflow.dll.so => 142
	i32 u0x3b45fb35, ; 237: System.IO.FileSystem => 51
	i32 u0x3b4797e5, ; 238: es/Microsoft.Maui.Controls.resources => 311
	i32 u0x3bb6bd33, ; 239: System.IO.UnmanagedMemoryStream.dll => 57
	i32 u0x3c5e5b62, ; 240: Xamarin.AndroidX.SavedState.dll => 275
	i32 u0x3cbffa41, ; 241: System.Drawing => 36
	i32 u0x3d548d92, ; 242: Microsoft.Extensions.DependencyInjection.Abstractions => 199
	i32 u0x3d5a6611, ; 243: da/Microsoft.Maui.Controls.resources.dll => 308
	i32 u0x3d7be038, ; 244: Xamarin.Google.ErrorProne.Annotations.dll => 293
	i32 u0x3dbaaf8f, ; 245: Xamarin.AndroidX.AppCompat => 223
	i32 u0x3dc84a49, ; 246: System.Drawing.Primitives.dll => 35
	i32 u0x3df150e9, ; 247: lib_Xamarin.AndroidX.Interpolator.dll.so => 249
	i32 u0x3e444eb4, ; 248: System.Linq.Expressions.dll => 59
	i32 u0x3e5c42fd, ; 249: lib_System.Reflection.TypeExtensions.dll.so => 97
	i32 u0x3e91eef5, ; 250: Google.Api.CommonProtos.dll => 179
	i32 u0x3eb776a1, ; 251: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 261
	i32 u0x3ebd41f6, ; 252: lib_System.Collections.dll.so => 12
	i32 u0x3ecd3024, ; 253: lib_System.Resources.Reader.dll.so => 99
	i32 u0x3eea4db8, ; 254: lib_Microsoft.Extensions.Primitives.dll.so => 204
	i32 u0x3f3e1e33, ; 255: lib_Xamarin.AndroidX.Lifecycle.Process.dll.so => 256
	i32 u0x3f9dcf8c, ; 256: GoogleGson => 190
	i32 u0x408b17f4, ; 257: System.ComponentModel.TypeConverter => 17
	i32 u0x409e66d8, ; 258: Xamarin.Kotlin.StdLib => 296
	i32 u0x41761b2c, ; 259: System => 165
	i32 u0x4232ae7b, ; 260: lib_System.Reflection.Emit.dll.so => 93
	i32 u0x42be2972, ; 261: lib_System.Text.Encodings.Web.dll.so => 137
	i32 u0x42c091c1, ; 262: lib_Xamarin.Android.Glide.GifDecoder.dll.so => 217
	i32 u0x42da3e50, ; 263: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll => 259
	i32 u0x43362f15, ; 264: Microsoft.Extensions.Logging.Debug => 202
	i32 u0x4393e151, ; 265: lib-th-Microsoft.Maui.Controls.resources.dll.so => 332
	i32 u0x441f18e1, ; 266: lib_System.Security.Cryptography.OpenSsl.dll.so => 124
	i32 u0x44409ee8, ; 267: System.Linq.Async.dll => 212
	i32 u0x444e5c8e, ; 268: lib_System.ComponentModel.TypeConverter.dll.so => 17
	i32 u0x44549c93, ; 269: lib_System.Net.WebProxy.dll.so => 79
	i32 u0x4474042c, ; 270: lib_System.Numerics.Vectors.dll.so => 83
	i32 u0x447dc2e6, ; 271: Xamarin.AndroidX.Window => 288
	i32 u0x44845810, ; 272: lib_System.Net.Http.dll.so => 65
	i32 u0x44c3958b, ; 273: lib_System.Private.DataContractSerialization.dll.so => 86
	i32 u0x45bde382, ; 274: lib_System.Windows.dll.so => 155
	i32 u0x45c677b2, ; 275: System.Web.dll => 154
	i32 u0x460b48eb, ; 276: Xamarin.AndroidX.VectorDrawable.Animated => 284
	i32 u0x463a8801, ; 277: Xamarin.AndroidX.Navigation.Runtime.dll => 269
	i32 u0x464305ed, ; 278: fi/Microsoft.Maui.Controls.resources => 312
	i32 u0x466ae52b, ; 279: lib_System.Threading.Overlapped.dll.so => 141
	i32 u0x47a87de7, ; 280: lib_System.Resources.Writer.dll.so => 101
	i32 u0x47b6f6a4, ; 281: Grpc.Net.Client => 193
	i32 u0x47b79c15, ; 282: pl/Microsoft.Maui.Controls.resources.dll => 325
	i32 u0x47c7b4fa, ; 283: Xamarin.AndroidX.Arch.Core.Common => 225
	i32 u0x480a69ad, ; 284: System.Diagnostics.Process => 29
	i32 u0x4868cc7b, ; 285: CommunityToolkit.Mvvm => 176
	i32 u0x48aa6be3, ; 286: System.IO.IsolatedStorage => 52
	i32 u0x48bf92c4, ; 287: lib_Xamarin.AndroidX.Collection.dll.so => 229
	i32 u0x49654709, ; 288: lib_System.Threading.Timer.dll.so => 148
	i32 u0x499b8219, ; 289: nb/Microsoft.Maui.Controls.resources.dll => 323
	i32 u0x4a0189ae, ; 290: lib-hi-Microsoft.Maui.Controls.resources.dll.so => 315
	i32 u0x4a18f6f7, ; 291: Xamarin.AndroidX.Window.Extensions.Core.Core.dll => 289
	i32 u0x4a4cd262, ; 292: Xamarin.AndroidX.Collection.Jvm.dll => 230
	i32 u0x4aaf6f7c, ; 293: Microsoft.Win32.Registry => 5
	i32 u0x4ae97402, ; 294: lib_Microsoft.Maui.Graphics.dll.so => 209
	i32 u0x4b275854, ; 295: Xamarin.KotlinX.Serialization.Core.Jvm => 303
	i32 u0x4b5eebe5, ; 296: Xamarin.AndroidX.Startup.StartupRuntime.dll => 279
	i32 u0x4b64b158, ; 297: Xamarin.KotlinX.Coroutines.Core.dll => 300
	i32 u0x4b863c7a, ; 298: lib_System.Private.Xml.Linq.dll.so => 88
	i32 u0x4b8a64a7, ; 299: Xamarin.AndroidX.VectorDrawable => 283
	i32 u0x4bb12d98, ; 300: lib_System.Runtime.Serialization.Xml.dll.so => 115
	i32 u0x4be46b58, ; 301: Xamarin.AndroidX.Collection.Ktx => 231
	i32 u0x4c071bea, ; 302: Xamarin.KotlinX.Coroutines.Android => 299
	i32 u0x4c3393c5, ; 303: Xamarin.AndroidX.Annotation.Jvm => 222
	i32 u0x4d14ee2b, ; 304: Xamarin.AndroidX.DrawerLayout.dll => 242
	i32 u0x4db40901, ; 305: DotNet.Meteor.HotReload.Plugin.dll => 177
	i32 u0x4de0ce3b, ; 306: lib_Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll.so => 272
	i32 u0x4e08a30b, ; 307: System.Private.DataContractSerialization => 86
	i32 u0x4e98c997, ; 308: lib_Xamarin.AndroidX.Window.Extensions.Core.Core.dll.so => 289
	i32 u0x4ed70c83, ; 309: Xamarin.AndroidX.Window.dll => 288
	i32 u0x4eed2679, ; 310: System.Linq => 62
	i32 u0x4f97822f, ; 311: System.Runtime.Serialization.Json.dll => 113
	i32 u0x50255dd9, ; 312: lib-hr-Microsoft.Maui.Controls.resources.dll.so => 316
	i32 u0x50acdfd7, ; 313: lib-ca-Microsoft.Maui.Controls.resources.dll.so => 306
	i32 u0x514d38cd, ; 314: System.IO => 58
	i32 u0x52114ed3, ; 315: Xamarin.AndroidX.SavedState => 275
	i32 u0x523dc4c1, ; 316: System.Resources.ResourceManager => 100
	i32 u0x52c90e9a, ; 317: DotNet.Meteor.HotReload.Plugin => 177
	i32 u0x533678bd, ; 318: lib_System.Private.CoreLib.dll.so => 173
	i32 u0x53701274, ; 319: lib_System.IO.FileSystem.Watcher.dll.so => 50
	i32 u0x53743864, ; 320: lib_BudgetPro.dll.so => 0
	i32 u0x53936ab4, ; 321: System.Configuration.dll => 19
	i32 u0x53cefc50, ; 322: Xamarin.AndroidX.CoordinatorLayout => 235
	i32 u0x53f80ba6, ; 323: System.Runtime.Serialization.Formatters.dll => 112
	i32 u0x5423e47b, ; 324: System.Runtime.CompilerServices.Unsafe => 102
	i32 u0x54246761, ; 325: lib_System.Diagnostics.Tools.dll.so => 32
	i32 u0x5498bac9, ; 326: lib_Microsoft.VisualBasic.dll.so => 3
	i32 u0x54ca50cb, ; 327: System.Runtime.CompilerServices.VisualC => 103
	i32 u0x557217fe, ; 328: lib_System.Numerics.dll.so => 84
	i32 u0x557b5293, ; 329: System.Runtime.Handles => 105
	i32 u0x558bc221, ; 330: Xamarin.Google.Crypto.Tink.Android.dll => 292
	i32 u0x55ab7451, ; 331: Xamarin.AndroidX.Lifecycle.Common.Jvm => 252
	i32 u0x55b1c5ad, ; 332: Grpc.Auth => 191
	i32 u0x55d10363, ; 333: System.Net.Quic.dll => 72
	i32 u0x55dfaca3, ; 334: lib_Microsoft.Win32.Primitives.dll.so => 4
	i32 u0x55e55df2, ; 335: Xamarin.AndroidX.Lifecycle.ViewModel.Android => 262
	i32 u0x568cd628, ; 336: System.Formats.Asn1.dll => 38
	i32 u0x569fcb36, ; 337: System.Diagnostics.Tools.dll => 32
	i32 u0x56c018af, ; 338: lib_System.IO.UnmanagedMemoryStream.dll.so => 57
	i32 u0x56e36530, ; 339: System.Runtime.Extensions.dll => 104
	i32 u0x56e7a7ad, ; 340: System.Net.Security.dll => 74
	i32 u0x5718a9ef, ; 341: System.Collections.Immutable.dll => 9
	i32 u0x57201017, ; 342: System.Security.Cryptography.OpenSsl => 124
	i32 u0x57261233, ; 343: System.IO.Compression.dll => 46
	i32 u0x57924923, ; 344: Xamarin.AndroidX.AppCompat.AppCompatResources => 224
	i32 u0x57a5e912, ; 345: Microsoft.Extensions.Primitives => 204
	i32 u0x5833866d, ; 346: System.Collections.Immutable => 9
	i32 u0x583e844f, ; 347: System.IO.Compression.Brotli.dll => 43
	i32 u0x58a57897, ; 348: Microsoft.Win32.Primitives => 4
	i32 u0x58cffa99, ; 349: Xamarin.AndroidX.SavedState.SavedState.Ktx.dll => 276
	i32 u0x58fd6613, ; 350: hi/Microsoft.Maui.Controls.resources.dll => 315
	i32 u0x596b5b3a, ; 351: lib_System.Drawing.Primitives.dll.so => 35
	i32 u0x5a48cf6c, ; 352: el/Microsoft.Maui.Controls.resources.dll => 310
	i32 u0x5b50046f, ; 353: lib_Zimba.Maui.dll.so => 304
	i32 u0x5b9331b6, ; 354: System.Diagnostics.TextWriterTraceListener => 31
	i32 u0x5be451c7, ; 355: lib_Xamarin.AndroidX.Browser.dll.so => 227
	i32 u0x5bf8ca0f, ; 356: System.Text.RegularExpressions.dll => 139
	i32 u0x5bfdbb43, ; 357: System.Reflection.Emit.dll => 93
	i32 u0x5c680b40, ; 358: System.Reflection.Extensions.dll => 94
	i32 u0x5c7be408, ; 359: sk/Microsoft.Maui.Controls.resources.dll => 330
	i32 u0x5cabc9a4, ; 360: fr/Microsoft.Maui.Controls.resources => 313
	i32 u0x5cf10dc4, ; 361: lib_Google.Apis.dll.so => 182
	i32 u0x5d28d4b1, ; 362: Zimba.Maui.dll => 304
	i32 u0x5d552ab7, ; 363: System.IO.FileSystem.Primitives => 49
	i32 u0x5d5a6c40, ; 364: System.Threading.Tasks.Dataflow.dll => 142
	i32 u0x5dccd455, ; 365: System.Runtime.Serialization.Json => 113
	i32 u0x5e0b6fdc, ; 366: Xamarin.KotlinX.Serialization.Core.Jvm.dll => 303
	i32 u0x5e2d7514, ; 367: System.Threading.Overlapped => 141
	i32 u0x5e2e3abe, ; 368: lib_Microsoft.VisualBasic.Core.dll.so => 2
	i32 u0x5e33306d, ; 369: sv/Microsoft.Maui.Controls.resources => 331
	i32 u0x5e5114e2, ; 370: Xamarin.AndroidX.DocumentFile.dll => 241
	i32 u0x5e7321d2, ; 371: lib_System.ComponentModel.Primitives.dll.so => 16
	i32 u0x5ed5f779, ; 372: zh-Hant/Microsoft.Maui.Controls.resources => 338
	i32 u0x5ef2ee25, ; 373: System.Runtime.Serialization.dll => 116
	i32 u0x5f3ec4dd, ; 374: Xamarin.Google.ErrorProne.Annotations => 293
	i32 u0x5f6f0b5b, ; 375: System.Xml.Serialization => 158
	i32 u0x5fa7b851, ; 376: System.Net.WebClient => 77
	i32 u0x6078995d, ; 377: System.Net.WebSockets.Client.dll => 80
	i32 u0x60892624, ; 378: lib_System.Formats.Tar.dll.so => 39
	i32 u0x60b0136a, ; 379: Xamarin.AndroidX.Loader.dll => 265
	i32 u0x60b33958, ; 380: System.Dynamic.Runtime => 37
	i32 u0x60d97228, ; 381: Xamarin.AndroidX.ViewPager2 => 287
	i32 u0x60ec189c, ; 382: lib_Xamarin.AndroidX.Arch.Core.Runtime.dll.so => 226
	i32 u0x616edae3, ; 383: CommunityToolkit.Maui.Core.dll => 175
	i32 u0x6176eff7, ; 384: Xamarin.AndroidX.Emoji2.ViewsHelper => 245
	i32 u0x6188ba7e, ; 385: Xamarin.AndroidX.CursorAdapter => 238
	i32 u0x61b9038d, ; 386: System.Net.Http.dll => 65
	i32 u0x61c036ca, ; 387: System.Text.RegularExpressions => 139
	i32 u0x61d59e0e, ; 388: System.ComponentModel.EventBasedAsync.dll => 15
	i32 u0x62021776, ; 389: lib_System.IO.Compression.dll.so => 46
	i32 u0x620a8774, ; 390: lib_System.Xml.ReaderWriter.dll.so => 157
	i32 u0x625755ef, ; 391: lib_WindowsBase.dll.so => 166
	i32 u0x62c6282e, ; 392: System.Runtime => 117
	i32 u0x62cec1a2, ; 393: lib_Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so => 301
	i32 u0x62d6c1e4, ; 394: Xamarin.AndroidX.Tracing.Tracing.dll => 281
	i32 u0x62d6ea10, ; 395: Xamarin.Google.Android.Material.dll => 290
	i32 u0x638b1991, ; 396: Xamarin.AndroidX.ConstraintLayout => 233
	i32 u0x63dee9da, ; 397: System.IO.FileSystem.DriveInfo.dll => 48
	i32 u0x63fca3d0, ; 398: System.Net.Primitives.dll => 71
	i32 u0x640c0103, ; 399: System.Net.WebSockets => 81
	i32 u0x641f3e5a, ; 400: System.Security.Cryptography => 127
	i32 u0x64d1e4f5, ; 401: System.Reflection.Metadata => 95
	i32 u0x6525abc9, ; 402: System.Security.Cryptography.Csp => 122
	i32 u0x654b1498, ; 403: lib_System.Transactions.Local.dll.so => 150
	i32 u0x656b7698, ; 404: System.Diagnostics.Debug.dll => 26
	i32 u0x6670b12e, ; 405: lib_System.Security.AccessControl.dll.so => 118
	i32 u0x66888819, ; 406: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx => 255
	i32 u0x66e27484, ; 407: System.Reflection.dll => 98
	i32 u0x66ffb0f8, ; 408: System.Diagnostics.FileVersionInfo.dll => 28
	i32 u0x6715dc86, ; 409: Xamarin.AndroidX.CardView.dll => 228
	i32 u0x67577fe1, ; 410: lib_System.Runtime.CompilerServices.VisualC.dll.so => 103
	i32 u0x677cd287, ; 411: ro/Microsoft.Maui.Controls.resources.dll => 328
	i32 u0x67fe8db2, ; 412: System.Transactions.Local.dll => 150
	i32 u0x68139a0d, ; 413: System.IO.Pipelines.dll => 54
	i32 u0x6816ab6a, ; 414: Mono.Android.Export => 170
	i32 u0x6853a83d, ; 415: Microsoft.Win32.Primitives.dll => 4
	i32 u0x68cc9d1e, ; 416: System.Resources.Reader.dll => 99
	i32 u0x68f61ae4, ; 417: lib_System.Formats.Asn1.dll.so => 38
	i32 u0x690d4b7d, ; 418: lib-zh-Hant-Microsoft.Maui.Controls.resources.dll.so => 338
	i32 u0x69239124, ; 419: System.Diagnostics.TraceSource.dll => 33
	i32 u0x693efa35, ; 420: lib_System.Net.WebHeaderCollection.dll.so => 78
	i32 u0x6942234e, ; 421: System.Reflection.Extensions => 94
	i32 u0x6947f945, ; 422: Xamarin.AndroidX.SwipeRefreshLayout => 280
	i32 u0x6988f147, ; 423: Microsoft.Extensions.Logging.dll => 200
	i32 u0x69ae5451, ; 424: lib_System.Runtime.InteropServices.JavaScript.dll.so => 106
	i32 u0x69dc03cc, ; 425: System.Core.dll => 21
	i32 u0x69ec0683, ; 426: System.Globalization.Extensions.dll => 41
	i32 u0x69f4f41d, ; 427: lib_Xamarin.AndroidX.AppCompat.dll.so => 223
	i32 u0x6a216153, ; 428: Mono.Android.Runtime.dll => 171
	i32 u0x6a39a035, ; 429: Grpc.Core.Api => 192
	i32 u0x6a539b49, ; 430: lib_System.Runtime.Extensions.dll.so => 104
	i32 u0x6a96652d, ; 431: Xamarin.AndroidX.Fragment => 247
	i32 u0x6afaf338, ; 432: lib_System.Threading.dll.so => 149
	i32 u0x6b0f58d2, ; 433: Microsoft.Bcl.AsyncInterfaces.dll => 195
	i32 u0x6b645ada, ; 434: lib-fr-Microsoft.Maui.Controls.resources.dll.so => 313
	i32 u0x6bca7890, ; 435: lib_System.CodeDom.dll.so => 211
	i32 u0x6bcd3296, ; 436: Xamarin.AndroidX.Loader => 265
	i32 u0x6be1e423, ; 437: nb/Microsoft.Maui.Controls.resources => 323
	i32 u0x6c111525, ; 438: Xamarin.Kotlin.StdLib.dll => 296
	i32 u0x6c13413e, ; 439: Xamarin.Google.Android.Material => 290
	i32 u0x6c5562e0, ; 440: lib_Xamarin.KotlinX.Coroutines.Core.dll.so => 300
	i32 u0x6c652ce8, ; 441: Xamarin.AndroidX.Navigation.UI.dll => 270
	i32 u0x6c687fa7, ; 442: Microsoft.VisualBasic.Core => 2
	i32 u0x6c96614d, ; 443: hu/Microsoft.Maui.Controls.resources => 317
	i32 u0x6cbab720, ; 444: System.Text.Encoding.Extensions => 135
	i32 u0x6cc30c8c, ; 445: System.Runtime.Serialization.Formatters => 112
	i32 u0x6cf3d432, ; 446: lib_Xamarin.AndroidX.VersionedParcelable.dll.so => 285
	i32 u0x6cff90ba, ; 447: Microsoft.Extensions.Logging.Abstractions.dll => 201
	i32 u0x6dcaebf7, ; 448: uk/Microsoft.Maui.Controls.resources.dll => 334
	i32 u0x6e1ed932, ; 449: Xamarin.Android.Glide.Annotations => 215
	i32 u0x6ec71a65, ; 450: System.Linq.Expressions => 59
	i32 u0x6f7a29e4, ; 451: System.Reflection.Primitives => 96
	i32 u0x6fab02f2, ; 452: lib_Xamarin.AndroidX.ConstraintLayout.dll.so => 233
	i32 u0x7009e4c3, ; 453: System.Formats.Tar.dll => 39
	i32 u0x705fa726, ; 454: Xamarin.AndroidX.Arch.Core.Runtime.dll => 226
	i32 u0x7070c6c0, ; 455: lib-zh-Hans-Microsoft.Maui.Controls.resources.dll.so => 337
	i32 u0x70972b6d, ; 456: System.Diagnostics.Contracts => 25
	i32 u0x70a66bdd, ; 457: System.Reflection.Metadata.dll => 95
	i32 u0x7124cf39, ; 458: System.Reflection.DispatchProxy => 90
	i32 u0x71479e77, ; 459: Grpc.Auth.dll => 191
	i32 u0x71490522, ; 460: System.Resources.ResourceManager.dll => 100
	i32 u0x71dc7c8b, ; 461: System.Collections.NonGeneric.dll => 10
	i32 u0x72e96247, ; 462: System.CodeDom.dll => 211
	i32 u0x72fcebde, ; 463: lib_Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so => 224
	i32 u0x731dd955, ; 464: lib_Mono.Android.dll.so => 172
	i32 u0x73495658, ; 465: lib_DotNet.Meteor.HotReload.Plugin.dll.so => 177
	i32 u0x739bd4a8, ; 466: System.Private.Xml.Linq => 88
	i32 u0x73b20433, ; 467: lib_System.IO.FileSystem.Primitives.dll.so => 49
	i32 u0x73bc0d8f, ; 468: lib_Google.LongRunning.dll.so => 188
	i32 u0x73fbecbe, ; 469: lib_System.Memory.dll.so => 63
	i32 u0x74126030, ; 470: lib_System.Net.WebClient.dll.so => 77
	i32 u0x74a1c5bb, ; 471: System.Resources.Writer => 101
	i32 u0x74d743bf, ; 472: ja/Microsoft.Maui.Controls.resources => 320
	i32 u0x74eee4ef, ; 473: Xamarin.AndroidX.Security.SecurityCrypto.dll => 277
	i32 u0x75533a5e, ; 474: Microsoft.Extensions.Configuration.dll => 196
	i32 u0x7593c33f, ; 475: lib_System.IO.FileSystem.AccessControl.dll.so => 47
	i32 u0x765c50a4, ; 476: Xamarin.Android.Glide.GifDecoder => 217
	i32 u0x77ec19b4, ; 477: System.Buffers.dll => 7
	i32 u0x781074ce, ; 478: hr/Microsoft.Maui.Controls.resources => 316
	i32 u0x784d3e49, ; 479: lib_System.Net.dll.so => 82
	i32 u0x785e97f1, ; 480: Xamarin.AndroidX.Lifecycle.ViewModel => 261
	i32 u0x78b622b1, ; 481: ar/Microsoft.Maui.Controls.resources.dll => 305
	i32 u0x790376c9, ; 482: lib_Xamarin.AndroidX.Annotation.Experimental.dll.so => 221
	i32 u0x791a414b, ; 483: Xamarin.Android.Glide => 214
	i32 u0x7970be4f, ; 484: lib-he-Microsoft.Maui.Controls.resources.dll.so => 314
	i32 u0x79abe959, ; 485: lib_Grpc.Net.Client.dll.so => 193
	i32 u0x79d00016, ; 486: it/Microsoft.Maui.Controls.resources => 319
	i32 u0x79eb68ee, ; 487: System.Private.Xml => 89
	i32 u0x7a80bd4e, ; 488: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 254
	i32 u0x7aca0819, ; 489: System.Windows.dll => 155
	i32 u0x7b350579, ; 490: lib__Microsoft.Android.Resource.Designer.dll.so => 339
	i32 u0x7b473a37, ; 491: lib_Xamarin.AndroidX.Fragment.Ktx.dll.so => 248
	i32 u0x7b6f419e, ; 492: System.Diagnostics.TraceSource => 33
	i32 u0x7b8f6ff7, ; 493: lib_System.Runtime.Serialization.Json.dll.so => 113
	i32 u0x7bf8cdab, ; 494: System.Runtime.dll => 117
	i32 u0x7c51ebd4, ; 495: lib_System.Net.HttpListener.dll.so => 66
	i32 u0x7c9bf920, ; 496: System.Numerics.Vectors => 83
	i32 u0x7d702d52, ; 497: lib_System.Text.Encoding.dll.so => 136
	i32 u0x7dd08168, ; 498: lib_Google.Protobuf.dll.so => 189
	i32 u0x7ec9ffe9, ; 499: System.Console => 20
	i32 u0x7fb38cd2, ; 500: System.Collections.Specialized => 11
	i32 u0x7fc7a41e, ; 501: System.Xml.XmlSerializer.dll => 163
	i32 u0x7fd90a71, ; 502: lib_System.Text.Encoding.CodePages.dll.so => 134
	i32 u0x7fdcdc37, ; 503: lib-ko-Microsoft.Maui.Controls.resources.dll.so => 321
	i32 u0x7ff65cf5, ; 504: Microsoft.VisualBasic.dll => 3
	i32 u0x802a7166, ; 505: lib_System.Diagnostics.FileVersionInfo.dll.so => 28
	i32 u0x8030853e, ; 506: ko/Microsoft.Maui.Controls.resources => 321
	i32 u0x8044e1bd, ; 507: lib-ms-Microsoft.Maui.Controls.resources.dll.so => 322
	i32 u0x8081c489, ; 508: lib_Jsr305Binding.dll.so => 291
	i32 u0x80bd55ad, ; 509: Microsoft.Maui => 207
	i32 u0x80f2f56e, ; 510: lib_System.Runtime.Serialization.Formatters.dll.so => 112
	i32 u0x810c11c2, ; 511: ro/Microsoft.Maui.Controls.resources => 328
	i32 u0x8115bdf3, ; 512: lib_System.Resources.ResourceManager.dll.so => 100
	i32 u0x816751d8, ; 513: lib_System.Diagnostics.DiagnosticSource.dll.so => 27
	i32 u0x81a110ae, ; 514: lib_System.ComponentModel.EventBasedAsync.dll.so => 15
	i32 u0x81dafee8, ; 515: System.CodeDom => 211
	i32 u0x820d22b3, ; 516: Microsoft.Extensions.Options.dll => 203
	i32 u0x82364da2, ; 517: lib_System.Buffers.dll.so => 7
	i32 u0x82a8237c, ; 518: Microsoft.Extensions.Logging.Abstractions => 201
	i32 u0x82b6c85e, ; 519: System.ObjectModel.dll => 85
	i32 u0x82bb5429, ; 520: lib_System.Linq.Expressions.dll.so => 59
	i32 u0x82c1cf3e, ; 521: lib_System.Net.Quic.dll.so => 72
	i32 u0x832ec206, ; 522: lib_System.Diagnostics.StackTrace.dll.so => 30
	i32 u0x83323b38, ; 523: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 301
	i32 u0x8334206b, ; 524: System.Net.Http => 65
	i32 u0x83924156, ; 525: lib_Google.Cloud.Firestore.dll.so => 185
	i32 u0x84206b70, ; 526: Firebase.Auth.dll => 178
	i32 u0x842e93b2, ; 527: Xamarin.AndroidX.VectorDrawable.Animated.dll => 284
	i32 u0x8471e4ec, ; 528: System.Threading.Tasks.Parallel => 144
	i32 u0x857e4dd2, ; 529: lib_System.Net.WebSockets.dll.so => 81
	i32 u0x85cc8d80, ; 530: Xamarin.AndroidX.LocalBroadcastManager => 266
	i32 u0x8628f1a4, ; 531: lib-ru-Microsoft.Maui.Controls.resources.dll.so => 329
	i32 u0x863c6ac5, ; 532: System.Xml.Serialization.dll => 158
	i32 u0x867c9c52, ; 533: System.Globalization.Extensions => 41
	i32 u0x86b0fd78, ; 534: lib_Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll.so => 263
	i32 u0x86bba59b, ; 535: lib_Microsoft.Maui.Controls.dll.so => 205
	i32 u0x8702d9a2, ; 536: System.Security.AccessControl.dll => 118
	i32 u0x871c9c1b, ; 537: Microsoft.Extensions.Configuration.Abstractions => 197
	i32 u0x872eeb7b, ; 538: Xamarin.Android.Glide.DiskLruCache.dll => 216
	i32 u0x875633cc, ; 539: fr/Microsoft.Maui.Controls.resources.dll => 313
	i32 u0x87a1a22b, ; 540: lib-it-Microsoft.Maui.Controls.resources.dll.so => 319
	i32 u0x87e25095, ; 541: Xamarin.AndroidX.RecyclerView.dll => 273
	i32 u0x87e7fdbb, ; 542: lib-nl-Microsoft.Maui.Controls.resources.dll.so => 324
	i32 u0x881f94da, ; 543: lib_netstandard.dll.so => 168
	i32 u0x8873eb17, ; 544: th/Microsoft.Maui.Controls.resources => 332
	i32 u0x887ae6a1, ; 545: lib_Xamarin.AndroidX.Lifecycle.Runtime.Android.dll.so => 258
	i32 u0x88acefcd, ; 546: System.ServiceModel.Web.dll => 132
	i32 u0x88d8bfaa, ; 547: System.Net.Sockets => 76
	i32 u0x88ffe49e, ; 548: System.Net.Mail => 67
	i32 u0x896b7878, ; 549: System.Private.CoreLib.dll => 173
	i32 u0x8a068af2, ; 550: Xamarin.AndroidX.Annotation.dll => 220
	i32 u0x8a52059a, ; 551: System.Threading.Tasks.Parallel.dll => 144
	i32 u0x8a92797b, ; 552: lib_Xamarin.AndroidX.DocumentFile.dll.so => 241
	i32 u0x8b804dbf, ; 553: System.Runtime.InteropServices.RuntimeInformation.dll => 107
	i32 u0x8bbaa2cd, ; 554: System.ValueTuple => 152
	i32 u0x8c20c628, ; 555: lib-fi-Microsoft.Maui.Controls.resources.dll.so => 312
	i32 u0x8c20f140, ; 556: lib_System.Console.dll.so => 20
	i32 u0x8c40e0db, ; 557: System.Net.Primitives => 71
	i32 u0x8d19e4a2, ; 558: lib_Xamarin.AndroidX.Lifecycle.LiveData.dll.so => 253
	i32 u0x8d24e767, ; 559: System.Xml.ReaderWriter.dll => 157
	i32 u0x8d3fac99, ; 560: tr/Microsoft.Maui.Controls.resources => 333
	i32 u0x8d52b2e2, ; 561: Microsoft.Extensions.Configuration => 196
	i32 u0x8d52d3de, ; 562: lib_System.Threading.Tasks.dll.so => 145
	i32 u0x8dc6dbce, ; 563: System.Security.Cryptography.Csp.dll => 122
	i32 u0x8dcb0101, ; 564: lib_Xamarin.AndroidX.Navigation.Fragment.dll.so => 268
	i32 u0x8e02310f, ; 565: lib-ar-Microsoft.Maui.Controls.resources.dll.so => 305
	i32 u0x8e114655, ; 566: System.Security.Principal.Windows.dll => 128
	i32 u0x8eddd55a, ; 567: BudgetPro.dll => 0
	i32 u0x8ee49f18, ; 568: Google.LongRunning.dll => 188
	i32 u0x8f24faee, ; 569: System.Web.HttpUtility => 153
	i32 u0x8f41c524, ; 570: Xamarin.AndroidX.Emoji2.dll => 244
	i32 u0x8f4e087a, ; 571: lib_System.Web.dll.so => 154
	i32 u0x8f8c64e2, ; 572: lib_System.Private.Xml.dll.so => 89
	i32 u0x905355ed, ; 573: System.Threading.Tasks.Dataflow => 142
	i32 u0x905caa9d, ; 574: nl/Microsoft.Maui.Controls.resources => 324
	i32 u0x906d466b, ; 575: Xamarin.AndroidX.Collection.Ktx.dll => 231
	i32 u0x90e50509, ; 576: lib_System.Reflection.Primitives.dll.so => 96
	i32 u0x911615a7, ; 577: lib_Xamarin.AndroidX.Fragment.dll.so => 247
	i32 u0x912896e5, ; 578: System.Console.dll => 20
	i32 u0x9130f5e7, ; 579: System.ComponentModel.DataAnnotations.dll => 14
	i32 u0x9181bfa1, ; 580: Google.Cloud.Firestore => 185
	i32 u0x91abdf3a, ; 581: lib_Xamarin.AndroidX.Startup.StartupRuntime.dll.so => 279
	i32 u0x924edee6, ; 582: System.Text.Encoding.dll => 136
	i32 u0x928c75ca, ; 583: System.Net.Sockets.dll => 76
	i32 u0x92916334, ; 584: System.Linq.Parallel.dll => 60
	i32 u0x92f50938, ; 585: Xamarin.AndroidX.ConstraintLayout.Core.dll => 234
	i32 u0x93554fdc, ; 586: netstandard.dll => 168
	i32 u0x93634cc0, ; 587: lib_Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll.so => 255
	i32 u0x93918882, ; 588: Java.Interop.dll => 169
	i32 u0x93dba8a1, ; 589: Microsoft.Maui.Controls => 205
	i32 u0x940d5c2f, ; 590: System.ComponentModel.EventBasedAsync => 15
	i32 u0x94147f61, ; 591: System.Net.ServicePoint => 75
	i32 u0x9438d78e, ; 592: lib_System.Text.Json.dll.so => 138
	i32 u0x943a4803, ; 593: Google.Api.Gax => 180
	i32 u0x9469ba86, ; 594: lib_Xamarin.AndroidX.Lifecycle.Runtime.dll.so => 257
	i32 u0x94798bc5, ; 595: System.AppContext.dll => 6
	i32 u0x94a1db18, ; 596: lib-id-Microsoft.Maui.Controls.resources.dll.so => 318
	i32 u0x94fad8e5, ; 597: lib_Xamarin.AndroidX.Activity.Ktx.dll.so => 219
	i32 u0x95178668, ; 598: System.Data.DataSetExtensions => 23
	i32 u0x95592891, ; 599: lib_Grpc.Net.Common.dll.so => 194
	i32 u0x955cf248, ; 600: Xamarin.AndroidX.Lifecycle.Runtime.dll => 257
	i32 u0x9593ae7f, ; 601: lib_Xamarin.AndroidX.SavedState.dll.so => 275
	i32 u0x963ac2da, ; 602: sk/Microsoft.Maui.Controls.resources => 330
	i32 u0x9659e17c, ; 603: Xamarin.Android.Glide.dll => 214
	i32 u0x96bea474, ; 604: lib_Microsoft.Maui.Controls.Xaml.dll.so => 206
	i32 u0x974b89a2, ; 605: System.Reflection.Emit.Lightweight.dll => 92
	i32 u0x98ba5a04, ; 606: Microsoft.CSharp => 1
	i32 u0x9930ee42, ; 607: System.Text.Encodings.Web => 137
	i32 u0x999dcf0d, ; 608: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.Android => 260
	i32 u0x99e2e424, ; 609: Xamarin.AndroidX.Lifecycle.Runtime.Ktx => 259
	i32 u0x99e370f2, ; 610: Xamarin.AndroidX.VectorDrawable.dll => 283
	i32 u0x9a1756ac, ; 611: System.Text.Encoding.Extensions.dll => 135
	i32 u0x9a20430d, ; 612: System.Net.Ping => 70
	i32 u0x9a5a3337, ; 613: System.Threading.ThreadPool => 147
	i32 u0x9b24ab96, ; 614: lib_System.Runtime.Serialization.Primitives.dll.so => 114
	i32 u0x9b500441, ; 615: Xamarin.KotlinX.Coroutines.Core.Jvm => 301
	i32 u0x9b5e5b1c, ; 616: lib_System.Diagnostics.Contracts.dll.so => 25
	i32 u0x9be14c08, ; 617: Xamarin.AndroidX.Fragment.Ktx => 248
	i32 u0x9bf052c1, ; 618: Microsoft.Extensions.Logging.Debug.dll => 202
	i32 u0x9bfe3a41, ; 619: System.Private.Xml.dll => 89
	i32 u0x9c165ff9, ; 620: System.Reflection.TypeExtensions.dll => 97
	i32 u0x9c375496, ; 621: Xamarin.AndroidX.CursorAdapter.dll => 238
	i32 u0x9c70e6c9, ; 622: Xamarin.AndroidX.DynamicAnimation => 243
	i32 u0x9c96ac4c, ; 623: lib_Xamarin.AndroidX.Navigation.UI.dll.so => 270
	i32 u0x9c97ad4a, ; 624: System.Diagnostics.TextWriterTraceListener.dll => 31
	i32 u0x9cc03a58, ; 625: System.IO.Compression.ZipFile.dll => 45
	i32 u0x9cd341b2, ; 626: lib_System.Threading.Tasks.Parallel.dll.so => 144
	i32 u0x9cf12c56, ; 627: Xamarin.AndroidX.Lifecycle.LiveData => 253
	i32 u0x9d1a17f0, ; 628: Google.Cloud.Firestore.dll => 185
	i32 u0x9e78dac1, ; 629: lib_Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so => 264
	i32 u0x9ec022c0, ; 630: Xamarin.Android.Glide.DiskLruCache => 216
	i32 u0x9ec4cf01, ; 631: System.Runtime.Loader => 110
	i32 u0x9ecf752a, ; 632: System.Xml.XDocument.dll => 159
	i32 u0x9ee22cc0, ; 633: System.Drawing.Primitives => 35
	i32 u0x9f3b757e, ; 634: Xamarin.KotlinX.Coroutines.Core => 300
	i32 u0x9f7ea921, ; 635: lib_System.Runtime.InteropServices.dll.so => 108
	i32 u0x9f8c6f40, ; 636: System.Data.Common.dll => 22
	i32 u0xa026a50c, ; 637: System.Runtime.Serialization.Xml.dll => 115
	i32 u0xa090e36a, ; 638: System.IO.dll => 58
	i32 u0xa0fb56af, ; 639: lib_System.Text.RegularExpressions.dll.so => 139
	i32 u0xa0ff7514, ; 640: Xamarin.AndroidX.Tracing.Tracing => 281
	i32 u0xa1d8b647, ; 641: System.Threading.Tasks.dll => 145
	i32 u0xa1fd7d9f, ; 642: System.Security.Claims => 119
	i32 u0xa21f5a1f, ; 643: System.Security.Cryptography.Cng.dll => 121
	i32 u0xa25c90e5, ; 644: lib_Xamarin.AndroidX.Core.dll.so => 236
	i32 u0xa262a30f, ; 645: System.Runtime.Numerics.dll => 111
	i32 u0xa2ce8457, ; 646: lib-es-Microsoft.Maui.Controls.resources.dll.so => 311
	i32 u0xa2e0939b, ; 647: Xamarin.AndroidX.Activity => 218
	i32 u0xa30769e5, ; 648: System.Threading.Channels => 140
	i32 u0xa32eb6f0, ; 649: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 224
	i32 u0xa35f8f92, ; 650: System.IO.Pipes.AccessControl => 55
	i32 u0xa3931c55, ; 651: Google.Api.Gax.Grpc.dll => 181
	i32 u0xa3c818c7, ; 652: lib_System.Net.WebSockets.Client.dll.so => 80
	i32 u0xa3cc7fa7, ; 653: System.Runtime.InteropServices.JavaScript => 106
	i32 u0xa45cf133, ; 654: Google.Api.Gax.Grpc => 181
	i32 u0xa4672f3b, ; 655: Microsoft.Maui.Controls.Xaml => 206
	i32 u0xa493aa02, ; 656: lib_System.Collections.Concurrent.dll.so => 8
	i32 u0xa4caf7a7, ; 657: Microsoft.Maui.dll => 207
	i32 u0xa4d4aaf8, ; 658: lib_System.Security.Cryptography.Cng.dll.so => 121
	i32 u0xa4db22c6, ; 659: System.Text.Encoding.CodePages.dll => 134
	i32 u0xa4e79dfd, ; 660: Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll => 262
	i32 u0xa522693c, ; 661: Xamarin.Jetbrains.Annotations.dll => 295
	i32 u0xa52ac270, ; 662: lib_Xamarin.AndroidX.Window.dll.so => 288
	i32 u0xa553c739, ; 663: lib_System.ValueTuple.dll.so => 152
	i32 u0xa5a0a402, ; 664: Xamarin.AndroidX.ViewPager.dll => 286
	i32 u0xa5b3182d, ; 665: Xamarin.AndroidX.ResourceInspection.Annotation.dll => 274
	i32 u0xa5b67c07, ; 666: Xamarin.AndroidX.Lifecycle.Common.Jvm.dll => 252
	i32 u0xa5c5753c, ; 667: lib_System.Collections.Immutable.dll.so => 9
	i32 u0xa5ea80d9, ; 668: lib_Xamarin.Android.Glide.Annotations.dll.so => 215
	i32 u0xa6133c7f, ; 669: lib_System.IO.FileSystem.DriveInfo.dll.so => 48
	i32 u0xa630ecdd, ; 670: Xamarin.AndroidX.Fragment.Ktx.dll => 248
	i32 u0xa668c988, ; 671: lib_System.Net.NameResolution.dll.so => 68
	i32 u0xa68df1f6, ; 672: lib_Google.Apis.Auth.dll.so => 183
	i32 u0xa7008e0b, ; 673: Microsoft.Maui.Graphics => 209
	i32 u0xa7042ae3, ; 674: uk/Microsoft.Maui.Controls.resources => 334
	i32 u0xa715dd7e, ; 675: System.Xml.XPath.XDocument.dll => 160
	i32 u0xa741ef0b, ; 676: es/Microsoft.Maui.Controls.resources.dll => 311
	i32 u0xa744f665, ; 677: lib_Xamarin.AndroidX.Navigation.Runtime.dll.so => 269
	i32 u0xa78103bc, ; 678: Xamarin.AndroidX.CoordinatorLayout.dll => 235
	i32 u0xa7fc6220, ; 679: System.Linq.Async => 212
	i32 u0xa8032c67, ; 680: lib_Microsoft.Win32.Registry.dll.so => 5
	i32 u0xa80db4e1, ; 681: System.Xml.dll => 164
	i32 u0xa81b119f, ; 682: lib_System.Security.Cryptography.dll.so => 127
	i32 u0xa8282c09, ; 683: System.ServiceProcess.dll => 133
	i32 u0xa8298928, ; 684: Xamarin.AndroidX.ResourceInspection.Annotation => 274
	i32 u0xa85a7b6c, ; 685: System.Xml.XmlDocument => 162
	i32 u0xa8c61dcb, ; 686: nl/Microsoft.Maui.Controls.resources.dll => 324
	i32 u0xa9379a4f, ; 687: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll => 263
	i32 u0xa942121b, ; 688: Google.LongRunning => 188
	i32 u0xa9d96f9b, ; 689: System.Threading.Overlapped.dll => 141
	i32 u0xaa107fc4, ; 690: Xamarin.AndroidX.ViewPager => 286
	i32 u0xaa2b531f, ; 691: lib_System.Globalization.dll.so => 42
	i32 u0xaa36a797, ; 692: Xamarin.AndroidX.Transition => 282
	i32 u0xaa4e51ff, ; 693: el/Microsoft.Maui.Controls.resources => 310
	i32 u0xaa88e550, ; 694: Mono.Android.Export.dll => 170
	i32 u0xaa8a4878, ; 695: Microsoft.Maui.Essentials => 208
	i32 u0xaaf9aad7, ; 696: CommunityToolkit.Maui.Core => 175
	i32 u0xab123e9a, ; 697: Xamarin.AndroidX.Activity.Ktx.dll => 219
	i32 u0xab5f85c3, ; 698: Jsr305Binding.dll => 291
	i32 u0xab606289, ; 699: System.Globalization.Calendars.dll => 40
	i32 u0xabbc23e8, ; 700: lib_Xamarin.KotlinX.Serialization.Core.Jvm.dll.so => 303
	i32 u0xabdea79a, ; 701: ru/Microsoft.Maui.Controls.resources => 329
	i32 u0xabf58099, ; 702: Xamarin.AndroidX.ExifInterface => 246
	i32 u0xac1dd496, ; 703: System.Net.dll => 82
	i32 u0xac7813f2, ; 704: Google.Apis.Core => 184
	i32 u0xacc231dd, ; 705: System.Management => 213
	i32 u0xacd6baa9, ; 706: System.IO.UnmanagedMemoryStream => 57
	i32 u0xace3f9b4, ; 707: System.Dynamic.Runtime.dll => 37
	i32 u0xace7ba82, ; 708: lib_System.Security.Principal.Windows.dll.so => 128
	i32 u0xacf080de, ; 709: System.Reflection => 98
	i32 u0xad2a79b6, ; 710: mscorlib.dll => 167
	i32 u0xad6f1e8a, ; 711: System.Private.CoreLib => 173
	i32 u0xad90894d, ; 712: lib_Xamarin.KotlinX.Serialization.Core.dll.so => 302
	i32 u0xad9b75ec, ; 713: Google.Api.CommonProtos => 179
	i32 u0xaddb6d38, ; 714: Xamarin.AndroidX.ViewPager2.dll => 287
	i32 u0xae037813, ; 715: System.Numerics.Vectors.dll => 83
	i32 u0xae1ce33f, ; 716: Xamarin.AndroidX.Annotation.Experimental.dll => 221
	i32 u0xaeb2d8a5, ; 717: lib_Microsoft.Extensions.Options.dll.so => 203
	i32 u0xaf06273c, ; 718: System.Resources.Reader => 99
	i32 u0xaf3a6b91, ; 719: lib_System.Diagnostics.Debug.dll.so => 26
	i32 u0xaf4af872, ; 720: System.Diagnostics.StackTrace.dll => 30
	i32 u0xaf624531, ; 721: System.Xml.XPath.XDocument => 160
	i32 u0xaf8b1081, ; 722: lib_Xamarin.AndroidX.SavedState.SavedState.Ktx.dll.so => 276
	i32 u0xb0682092, ; 723: System.ComponentModel.dll => 18
	i32 u0xb0ed41f3, ; 724: System.Security.Principal.Windows => 128
	i32 u0xb128f886, ; 725: System.Security.Cryptography.Algorithms.dll => 120
	i32 u0xb18af942, ; 726: Xamarin.AndroidX.DrawerLayout => 242
	i32 u0xb1a434a2, ; 727: lib_System.Xml.Linq.dll.so => 156
	i32 u0xb1a7d210, ; 728: lib_Xamarin.AndroidX.Lifecycle.Runtime.Ktx.Android.dll.so => 260
	i32 u0xb21220a3, ; 729: Xamarin.AndroidX.Security.SecurityCrypto => 277
	i32 u0xb223fa8c, ; 730: lib-cs-Microsoft.Maui.Controls.resources.dll.so => 307
	i32 u0xb2410258, ; 731: Google.Apis => 182
	i32 u0xb28cab85, ; 732: lib_Xamarin.Android.Glide.DiskLruCache.dll.so => 216
	i32 u0xb294d40b, ; 733: lib_System.Net.Ping.dll.so => 70
	i32 u0xb2a03f9f, ; 734: Xamarin.AndroidX.Lifecycle.Process.dll => 256
	i32 u0xb3d3821c, ; 735: Xamarin.AndroidX.Startup.StartupRuntime => 279
	i32 u0xb434b64b, ; 736: WindowsBase.dll => 166
	i32 u0xb443fdf2, ; 737: Xamarin.AndroidX.Legacy.Support.Core.Utils => 250
	i32 u0xb514b305, ; 738: _Microsoft.Android.Resource.Designer.dll => 339
	i32 u0xb58d85d9, ; 739: lib_System.Runtime.Handles.dll.so => 105
	i32 u0xb62a9ccb, ; 740: Xamarin.AndroidX.SavedState.SavedState.Ktx => 276
	i32 u0xb63fa9f0, ; 741: Xamarin.AndroidX.Navigation.Common => 267
	i32 u0xb6490b5e, ; 742: lib_Mono.Android.Export.dll.so => 170
	i32 u0xb65adef9, ; 743: Mono.Android.Runtime => 171
	i32 u0xb660be12, ; 744: System.ComponentModel.Primitives => 16
	i32 u0xb6a153b2, ; 745: lib_Xamarin.AndroidX.ViewPager2.dll.so => 287
	i32 u0xb70c6fb4, ; 746: lib_Xamarin.AndroidX.VectorDrawable.dll.so => 283
	i32 u0xb755818f, ; 747: System.Threading.Tasks => 145
	i32 u0xb76be845, ; 748: hu/Microsoft.Maui.Controls.resources.dll => 317
	i32 u0xb7e7c341, ; 749: lib_System.Globalization.Calendars.dll.so => 40
	i32 u0xb838e2b0, ; 750: System.Security.Cryptography.X509Certificates.dll => 126
	i32 u0xb8c22b7f, ; 751: System.Security.Claims.dll => 119
	i32 u0xb8fd311b, ; 752: System.Formats.Asn1 => 38
	i32 u0xb925d155, ; 753: Grpc.Net.Common.dll => 194
	i32 u0xb979e222, ; 754: System.Runtime.Serialization => 116
	i32 u0xba0dbf1c, ; 755: System.IO.FileSystem.AccessControl.dll => 47
	i32 u0xba4127cb, ; 756: System.Threading.Tasks.Extensions => 143
	i32 u0xbaa520e7, ; 757: lib_System.ObjectModel.dll.so => 85
	i32 u0xbab301d1, ; 758: System.Security.AccessControl => 118
	i32 u0xbb7561b0, ; 759: lib_Google.Cloud.Location.dll.so => 187
	i32 u0xbb95ee37, ; 760: System.Diagnostics.Tracing.dll => 34
	i32 u0xbba64c02, ; 761: GoogleGson.dll => 190
	i32 u0xbc4c6465, ; 762: System.Reflection.Primitives.dll => 96
	i32 u0xbc652da7, ; 763: System.IO.MemoryMappedFiles => 53
	i32 u0xbc98c93d, ; 764: lib_Xamarin.AndroidX.Collection.Jvm.dll.so => 230
	i32 u0xbcc610a0, ; 765: lib_System.Reflection.Metadata.dll.so => 95
	i32 u0xbd113355, ; 766: lib_Xamarin.AndroidX.Navigation.Common.dll.so => 267
	i32 u0xbd78b0c8, ; 767: Xamarin.AndroidX.Navigation.Fragment.dll => 268
	i32 u0xbddce8a2, ; 768: lib_System.Security.Principal.dll.so => 129
	i32 u0xbe3f07c2, ; 769: lib_System.Runtime.CompilerServices.Unsafe.dll.so => 102
	i32 u0xbe4755f4, ; 770: System.Security.SecureString => 130
	i32 u0xbe592c0c, ; 771: System.Web => 154
	i32 u0xbeee243d, ; 772: Google.Api.Gax.dll => 180
	i32 u0xbefef58f, ; 773: System.Data.dll => 24
	i32 u0xbf506931, ; 774: System.Xml.XmlDocument.dll => 162
	i32 u0xbf6fd745, ; 775: Xamarin.AndroidX.DocumentFile => 241
	i32 u0xbff2e236, ; 776: System.Threading => 149
	i32 u0xc00e375b, ; 777: lib_Newtonsoft.Json.dll.so => 210
	i32 u0xc04c3c0a, ; 778: System.Runtime.Handles.dll => 105
	i32 u0xc095e070, ; 779: lib_Xamarin.AndroidX.Lifecycle.Common.dll.so => 251
	i32 u0xc1c6ebf4, ; 780: System.Reflection.DispatchProxy.dll => 90
	i32 u0xc217efb6, ; 781: lib_Xamarin.AndroidX.ConstraintLayout.Core.dll.so => 234
	i32 u0xc235e84d, ; 782: Xamarin.AndroidX.CardView => 228
	i32 u0xc2a37b91, ; 783: System.Linq.Queryable.dll => 61
	i32 u0xc2a993fa, ; 784: System.Threading.Tasks.Extensions.dll => 143
	i32 u0xc3428433, ; 785: lib_System.Reflection.Emit.ILGeneration.dll.so => 91
	i32 u0xc35f7fa4, ; 786: System.Resources.Writer.dll => 101
	i32 u0xc37f65ce, ; 787: Microsoft.Win32.Registry.dll => 5
	i32 u0xc3888e16, ; 788: System.ComponentModel.Annotations.dll => 13
	i32 u0xc3ba1d80, ; 789: lib_System.Security.Cryptography.Csp.dll.so => 122
	i32 u0xc4251ff9, ; 790: System.Security.Cryptography.Encoding => 123
	i32 u0xc4684d9e, ; 791: lib_System.Security.Cryptography.Algorithms.dll.so => 120
	i32 u0xc4a8494a, ; 792: System.Text.Encoding => 136
	i32 u0xc4e76306, ; 793: System.Diagnostics.FileVersionInfo => 28
	i32 u0xc591efe9, ; 794: lib_Microsoft.Extensions.Configuration.Abstractions.dll.so => 197
	i32 u0xc5b097e4, ; 795: System.Net.Requests.dll => 73
	i32 u0xc5b776df, ; 796: Xamarin.AndroidX.CustomView.dll => 239
	i32 u0xc5b79d28, ; 797: System.Data => 24
	i32 u0xc69f3b41, ; 798: lib_System.Data.dll.so => 24
	i32 u0xc71af05d, ; 799: Xamarin.AndroidX.Arch.Core.Runtime => 226
	i32 u0xc76e512c, ; 800: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll => 272
	i32 u0xc774da4f, ; 801: Xamarin.AndroidX.Navigation.Runtime => 269
	i32 u0xc7a3b0f0, ; 802: lib_Xamarin.AndroidX.Transition.dll.so => 282
	i32 u0xc7b797d0, ; 803: lib_Xamarin.AndroidX.Core.Core.Ktx.dll.so => 237
	i32 u0xc821fc10, ; 804: lib_System.ComponentModel.dll.so => 18
	i32 u0xc82afec1, ; 805: System.Text.Json => 138
	i32 u0xc8693088, ; 806: Xamarin.AndroidX.Activity.Ktx => 219
	i32 u0xc86c06e3, ; 807: Xamarin.AndroidX.Core => 236
	i32 u0xc8a662e9, ; 808: Java.Interop => 169
	i32 u0xc8d10307, ; 809: lib_System.Diagnostics.TraceSource.dll.so => 33
	i32 u0xc92a6809, ; 810: Xamarin.AndroidX.RecyclerView => 273
	i32 u0xca5de1fa, ; 811: System.Runtime.CompilerServices.Unsafe.dll => 102
	i32 u0xcae37e41, ; 812: System.Security.Cryptography.OpenSsl.dll => 124
	i32 u0xcaf7bd4b, ; 813: Xamarin.AndroidX.CustomView.PoolingContainer => 240
	i32 u0xcb5af55c, ; 814: lib_System.Reflection.Emit.Lightweight.dll.so => 92
	i32 u0xcc5af6ee, ; 815: Microsoft.Extensions.DependencyInjection.dll => 198
	i32 u0xcc6479a0, ; 816: System.Xml => 164
	i32 u0xcc7d82b4, ; 817: netstandard => 168
	i32 u0xcd1dd0db, ; 818: Xamarin.AndroidX.DynamicAnimation.dll => 243
	i32 u0xcd5a809f, ; 819: System.Formats.Tar => 39
	i32 u0xcdd51fd6, ; 820: lib_Grpc.Core.Api.dll.so => 192
	i32 u0xcdd8cd54, ; 821: lib_Xamarin.AndroidX.Emoji2.dll.so => 244
	i32 u0xcdd9a3ea, ; 822: Google.Apis.Core.dll => 184
	i32 u0xce3fa116, ; 823: lib_System.Diagnostics.Process.dll.so => 29
	i32 u0xce70fda2, ; 824: hr/Microsoft.Maui.Controls.resources.dll => 316
	i32 u0xcef19b37, ; 825: System.ComponentModel.TypeConverter.dll => 17
	i32 u0xcf3163e6, ; 826: Mono.Android => 172
	i32 u0xcf663a21, ; 827: ru/Microsoft.Maui.Controls.resources.dll => 329
	i32 u0xcfa20c36, ; 828: lib_Xamarin.AndroidX.SwipeRefreshLayout.dll.so => 280
	i32 u0xcfbaacae, ; 829: System.Text.Json.dll => 138
	i32 u0xcfd0c798, ; 830: System.Transactions => 151
	i32 u0xd0418592, ; 831: Xamarin.AndroidX.Concurrent.Futures.dll => 232
	i32 u0xd08ffc7a, ; 832: Google.Protobuf.dll => 189
	i32 u0xd0f73226, ; 833: lib_Xamarin.KotlinX.AtomicFU.Jvm.dll.so => 298
	i32 u0xd128d608, ; 834: System.Xml.Linq => 156
	i32 u0xd1854eb4, ; 835: System.Security.dll => 131
	i32 u0xd2757232, ; 836: System.Configuration => 19
	i32 u0xd2ff69f1, ; 837: System.Net.HttpListener => 66
	i32 u0xd310c033, ; 838: lib_Xamarin.Jetbrains.Annotations.dll.so => 295
	i32 u0xd328ac54, ; 839: vi/Microsoft.Maui.Controls.resources => 335
	i32 u0xd4045e1b, ; 840: lib_System.dll.so => 165
	i32 u0xd404ddfe, ; 841: lib_System.Runtime.Intrinsics.dll.so => 109
	i32 u0xd432d20b, ; 842: System.Threading.Timer => 148
	i32 u0xd457e5c9, ; 843: lib_Microsoft.CSharp.dll.so => 1
	i32 u0xd47cb45a, ; 844: lib_Xamarin.AndroidX.Arch.Core.Common.dll.so => 225
	i32 u0xd496c3c3, ; 845: lib_Xamarin.AndroidX.ExifInterface.dll.so => 246
	i32 u0xd4d2575b, ; 846: System.IO.FileSystem.AccessControl => 47
	i32 u0xd505225a, ; 847: lib_System.Xml.XPath.dll.so => 161
	i32 u0xd5307c10, ; 848: Zimba.Maui => 304
	i32 u0xd622b752, ; 849: lib-ro-Microsoft.Maui.Controls.resources.dll.so => 328
	i32 u0xd664cdf2, ; 850: de/Microsoft.Maui.Controls.resources => 309
	i32 u0xd6665034, ; 851: Xamarin.Android.Glide.GifDecoder.dll => 217
	i32 u0xd676179d, ; 852: Google.Cloud.Firestore.V1 => 186
	i32 u0xd67a52b3, ; 853: System.Net.WebSockets.Client => 80
	i32 u0xd70d7bba, ; 854: BudgetPro => 0
	i32 u0xd715a361, ; 855: System.Linq.dll => 62
	i32 u0xd751624c, ; 856: System.Management.dll => 213
	i32 u0xd7f95f5a, ; 857: da/Microsoft.Maui.Controls.resources => 308
	i32 u0xd804d57a, ; 858: System.Runtime.InteropServices.RuntimeInformation => 107
	i32 u0xd832fda6, ; 859: Xamarin.AndroidX.Print.dll => 271
	i32 u0xd889aee8, ; 860: lib_System.Threading.Channels.dll.so => 140
	i32 u0xd8950487, ; 861: Xamarin.AndroidX.Annotation.Experimental => 221
	i32 u0xd8bba49d, ; 862: lib_Xamarin.AndroidX.RecyclerView.dll.so => 273
	i32 u0xd8dbab5d, ; 863: System.IO.FileSystem.Primitives.dll => 49
	i32 u0xd90e5f5a, ; 864: Xamarin.AndroidX.Lifecycle.LiveData.Core => 254
	i32 u0xd92e86f1, ; 865: Xamarin.KotlinX.Serialization.Core.dll => 302
	i32 u0xd930cda0, ; 866: Xamarin.AndroidX.Navigation.Fragment => 268
	i32 u0xd943a729, ; 867: System.ComponentModel.DataAnnotations => 14
	i32 u0xd94bea07, ; 868: Google.Protobuf => 189
	i32 u0xd96cf6f7, ; 869: pt-BR/Microsoft.Maui.Controls.resources => 326
	i32 u0xd9f65f5e, ; 870: lib-el-Microsoft.Maui.Controls.resources.dll.so => 310
	i32 u0xd9fdda56, ; 871: Microsoft.Extensions.Configuration.Abstractions.dll => 197
	i32 u0xda2f27df, ; 872: System.Net.NetworkInformation => 69
	i32 u0xda4773dd, ; 873: he/Microsoft.Maui.Controls.resources => 314
	i32 u0xdabf74ac, ; 874: lib_Xamarin.AndroidX.Annotation.Jvm.dll.so => 222
	i32 u0xdae8aa5e, ; 875: Mono.Android.dll => 172
	i32 u0xdb7f7e5d, ; 876: Xamarin.AndroidX.Browser => 227
	i32 u0xdb9df1ce, ; 877: Xamarin.AndroidX.Concurrent.Futures => 232
	i32 u0xdbb50d93, ; 878: ms/Microsoft.Maui.Controls.resources => 322
	i32 u0xdc5370c5, ; 879: lib_System.Web.HttpUtility.dll.so => 153
	i32 u0xdc68940c, ; 880: zh-Hant/Microsoft.Maui.Controls.resources.dll => 338
	i32 u0xdc96bdf5, ; 881: System.Net.WebProxy.dll => 79
	i32 u0xdcefb51d, ; 882: Xamarin.AndroidX.Core.Core.Ktx.dll => 237
	i32 u0xdd864306, ; 883: System.Runtime.Intrinsics => 109
	i32 u0xdda814c6, ; 884: Xamarin.AndroidX.Annotation => 220
	i32 u0xde068c70, ; 885: Xamarin.AndroidX.Navigation.Common.dll => 267
	i32 u0xde7354ab, ; 886: System.Net.NameResolution => 68
	i32 u0xdecad304, ; 887: System.Net.Http.Json.dll => 64
	i32 u0xdf1b1ecd, ; 888: lib_System.ServiceProcess.dll.so => 133
	i32 u0xdf6f3870, ; 889: System.Diagnostics.DiagnosticSource => 27
	i32 u0xdf9a7f42, ; 890: System.Xml.XPath => 161
	i32 u0xdfd65a5d, ; 891: lib_System.Diagnostics.Tracing.dll.so => 34
	i32 u0xdffe768c, ; 892: Google.Cloud.Location.dll => 187
	i32 u0xe05b6245, ; 893: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.Android.dll => 260
	i32 u0xe082f700, ; 894: lib_Xamarin.AndroidX.Print.dll.so => 271
	i32 u0xe0dec2ee, ; 895: lib_CommunityToolkit.Maui.dll.so => 174
	i32 u0xe12f62fc, ; 896: lib_System.Threading.ThreadPool.dll.so => 147
	i32 u0xe13414bb, ; 897: lib-hu-Microsoft.Maui.Controls.resources.dll.so => 317
	i32 u0xe1a41194, ; 898: lib_System.Xml.XDocument.dll.so => 159
	i32 u0xe1ae15d6, ; 899: Xamarin.AndroidX.Collection => 229
	i32 u0xe1eea3e4, ; 900: lib_System.IO.Compression.ZipFile.dll.so => 45
	i32 u0xe1f0a5d8, ; 901: lib_Xamarin.AndroidX.ViewPager.dll.so => 286
	i32 u0xe2098b0b, ; 902: System.Collections.NonGeneric => 10
	i32 u0xe223ce9c, ; 903: Google.Apis.Auth.dll => 183
	i32 u0xe250cda6, ; 904: lib_Microsoft.Extensions.Logging.dll.so => 200
	i32 u0xe2513246, ; 905: lib_System.Runtime.Numerics.dll.so => 111
	i32 u0xe27c1b41, ; 906: lib_Xamarin.KotlinX.AtomicFU.dll.so => 297
	i32 u0xe2a3f2e8, ; 907: System.Collections.Specialized.dll => 11
	i32 u0xe34ee011, ; 908: lib_System.IO.Pipelines.dll.so => 54
	i32 u0xe3774f52, ; 909: lib_System.IO.MemoryMappedFiles.dll.so => 53
	i32 u0xe3886bf7, ; 910: CommunityToolkit.Maui.dll => 174
	i32 u0xe3a54a09, ; 911: System.Net.WebProxy => 79
	i32 u0xe3c7860c, ; 912: lib_System.Security.Claims.dll.so => 119
	i32 u0xe3df9d2b, ; 913: System.Security.Cryptography.dll => 127
	i32 u0xe4436460, ; 914: System.Numerics.dll => 84
	i32 u0xe4fab729, ; 915: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 199
	i32 u0xe52378b9, ; 916: System.Net.Mail.dll => 67
	i32 u0xe56ef253, ; 917: System.Runtime.InteropServices.dll => 108
	i32 u0xe625b819, ; 918: lib_Xamarin.AndroidX.CardView.dll.so => 228
	i32 u0xe6b14171, ; 919: System.Net.HttpListener.dll => 66
	i32 u0xe6ca3640, ; 920: lib_Xamarin.AndroidX.Collection.Ktx.dll.so => 231
	i32 u0xe6e179fa, ; 921: System.Security.Principal => 129
	i32 u0xe6f98713, ; 922: System.Security.Cryptography.Encoding.dll => 123
	i32 u0xe797fcc1, ; 923: System.Net.WebHeaderCollection.dll => 78
	i32 u0xe79e77a6, ; 924: Xamarin.AndroidX.Transition.dll => 282
	i32 u0xe7c9e2bd, ; 925: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller => 272
	i32 u0xe7dc15ff, ; 926: zh-Hans/Microsoft.Maui.Controls.resources.dll => 337
	i32 u0xe839deed, ; 927: System.Collections.Concurrent.dll => 8
	i32 u0xe843daa0, ; 928: Xamarin.AndroidX.Core.dll => 236
	i32 u0xe89260c1, ; 929: Microsoft.VisualBasic.Core.dll => 2
	i32 u0xe90fdb70, ; 930: Xamarin.AndroidX.Collection.Jvm => 230
	i32 u0xe92ace5f, ; 931: lib_System.Linq.Parallel.dll.so => 60
	i32 u0xe99f7d24, ; 932: lib-tr-Microsoft.Maui.Controls.resources.dll.so => 333
	i32 u0xe9b2d35e, ; 933: System.IO.Compression.FileSystem.dll => 44
	i32 u0xe9b630ed, ; 934: Xamarin.AndroidX.VersionedParcelable.dll => 285
	i32 u0xea0092d6, ; 935: lib_System.Threading.Tasks.Extensions.dll.so => 143
	i32 u0xea213423, ; 936: System.Xml.ReaderWriter => 157
	i32 u0xea4780ec, ; 937: System.Security.Principal.dll => 129
	i32 u0xea4fb52e, ; 938: Xamarin.AndroidX.Navigation.UI => 270
	i32 u0xeab81858, ; 939: lib_Microsoft.Maui.Essentials.dll.so => 208
	i32 u0xeaf244cc, ; 940: lib_System.IO.Pipes.AccessControl.dll.so => 55
	i32 u0xeaf598f6, ; 941: lib_Microsoft.Extensions.Logging.Abstractions.dll.so => 201
	i32 u0xeb2ecede, ; 942: System.Data.DataSetExtensions.dll => 23
	i32 u0xeb5560c9, ; 943: lib_System.Runtime.InteropServices.RuntimeInformation.dll.so => 107
	i32 u0xebac8bfe, ; 944: System.Text.Encoding.CodePages => 134
	i32 u0xebb0254b, ; 945: lib_System.Net.NetworkInformation.dll.so => 69
	i32 u0xebc66336, ; 946: Xamarin.AndroidX.AppCompat.dll => 223
	i32 u0xec05582d, ; 947: Xamarin.AndroidX.Lifecycle.Process => 256
	i32 u0xed1090ae, ; 948: lib_System.Net.Primitives.dll.so => 71
	i32 u0xed409aea, ; 949: th/Microsoft.Maui.Controls.resources.dll => 332
	i32 u0xed96d41f, ; 950: lib_Xamarin.AndroidX.CoordinatorLayout.dll.so => 235
	i32 u0xedadd6e2, ; 951: he/Microsoft.Maui.Controls.resources.dll => 314
	i32 u0xedf6669b, ; 952: lib_System.Drawing.dll.so => 36
	i32 u0xee9f991d, ; 953: System.Diagnostics.Process.dll => 29
	i32 u0xeeefb9c8, ; 954: lib_System.Dynamic.Runtime.dll.so => 37
	i32 u0xef5e8475, ; 955: Xamarin.AndroidX.Annotation.Jvm.dll => 222
	i32 u0xefd01a89, ; 956: System.IO.Pipelines => 54
	i32 u0xefd991db, ; 957: Firebase.Auth => 178
	i32 u0xeff49a63, ; 958: System.Memory => 63
	i32 u0xeff49c4a, ; 959: lib_System.Text.Encoding.Extensions.dll.so => 135
	i32 u0xf09122fc, ; 960: lib_System.IO.IsolatedStorage.dll.so => 52
	i32 u0xf121f953, ; 961: lib_Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so => 254
	i32 u0xf1304331, ; 962: Microsoft.Maui.Controls.Xaml.dll => 206
	i32 u0xf15cb56d, ; 963: Xamarin.KotlinX.Serialization.Core => 302
	i32 u0xf1676aaa, ; 964: lib-da-Microsoft.Maui.Controls.resources.dll.so => 308
	i32 u0xf1ad867b, ; 965: System.Reflection.Emit.ILGeneration => 91
	i32 u0xf1c3db15, ; 966: Google.Cloud.Location => 187
	i32 u0xf1f9d7a6, ; 967: Google.Apis.dll => 182
	i32 u0xf27f60d1, ; 968: System.Private.Xml.Linq.dll => 88
	i32 u0xf29c5384, ; 969: id/Microsoft.Maui.Controls.resources => 318
	i32 u0xf2ce3c98, ; 970: System.Threading.dll => 149
	i32 u0xf2dd3fc4, ; 971: lib-ja-Microsoft.Maui.Controls.resources.dll.so => 320
	i32 u0xf323e0a6, ; 972: lib_Xamarin.Kotlin.StdLib.dll.so => 296
	i32 u0xf33c42ef, ; 973: lib_Xamarin.AndroidX.VectorDrawable.Animated.dll.so => 284
	i32 u0xf35bd7a3, ; 974: Google.Apis.Auth => 183
	i32 u0xf3a16066, ; 975: lib_Xamarin.AndroidX.Lifecycle.ViewModel.dll.so => 261
	i32 u0xf40add04, ; 976: Microsoft.Maui.Essentials.dll => 208
	i32 u0xf42589bc, ; 977: lib_System.Security.Cryptography.X509Certificates.dll.so => 126
	i32 u0xf45985cf, ; 978: System.Drawing.dll => 36
	i32 u0xf462c30d, ; 979: System.Private.Uri => 87
	i32 u0xf479582c, ; 980: Xamarin.AndroidX.Emoji2 => 244
	i32 u0xf47b0a29, ; 981: lib_System.Configuration.dll.so => 19
	i32 u0xf48143e5, ; 982: pt/Microsoft.Maui.Controls.resources.dll => 327
	i32 u0xf4990bd6, ; 983: lib_System.Linq.Async.dll.so => 212
	i32 u0xf5185c24, ; 984: lib-pt-Microsoft.Maui.Controls.resources.dll.so => 327
	i32 u0xf53cb11d, ; 985: lib_System.Net.Security.dll.so => 74
	i32 u0xf5861a4f, ; 986: pl/Microsoft.Maui.Controls.resources => 325
	i32 u0xf5e94e90, ; 987: ms/Microsoft.Maui.Controls.resources.dll => 322
	i32 u0xf5f4f1f0, ; 988: Microsoft.Extensions.DependencyInjection => 198
	i32 u0xf5fdf056, ; 989: lib_Microsoft.Extensions.DependencyInjection.dll.so => 198
	i32 u0xf60736e2, ; 990: System.IO.FileSystem.Watcher => 50
	i32 u0xf6318da0, ; 991: System.AppContext => 6
	i32 u0xf73be021, ; 992: System.Reflection.Emit.ILGeneration.dll => 91
	i32 u0xf76edc75, ; 993: System.Core => 21
	i32 u0xf7e95c85, ; 994: System.Xml.XmlSerializer => 163
	i32 u0xf807b767, ; 995: System.Reflection.TypeExtensions => 97
	i32 u0xf83dd773, ; 996: System.IO.FileSystem.Watcher.dll => 50
	i32 u0xf86129d4, ; 997: lib-sv-Microsoft.Maui.Controls.resources.dll.so => 331
	i32 u0xf93ba7d4, ; 998: System.Runtime.Serialization.Primitives => 114
	i32 u0xf94a8f86, ; 999: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 264
	i32 u0xf97c5a99, ; 1000: System.Security => 131
	i32 u0xfa21f6af, ; 1001: System.Net.WebClient.dll => 77
	i32 u0xfa50891f, ; 1002: lib_System.Linq.dll.so => 62
	i32 u0xfa6ae1e2, ; 1003: lib_Xamarin.AndroidX.Annotation.dll.so => 220
	i32 u0xfaf0dda8, ; 1004: lib_CommunityToolkit.Mvvm.dll.so => 176
	i32 u0xfb0af295, ; 1005: lib-zh-HK-Microsoft.Maui.Controls.resources.dll.so => 336
	i32 u0xfb1dad5d, ; 1006: System.Diagnostics.DiagnosticSource.dll => 27
	i32 u0xfbc4b67c, ; 1007: lib_System.IO.Compression.Brotli.dll.so => 43
	i32 u0xfc0a7526, ; 1008: Xamarin.KotlinX.AtomicFU.Jvm.dll => 298
	i32 u0xfc5f7d36, ; 1009: pt/Microsoft.Maui.Controls.resources => 327
	i32 u0xfdaee526, ; 1010: Xamarin.AndroidX.Core.Core.Ktx => 237
	i32 u0xfdd1b433, ; 1011: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx => 263
	i32 u0xfdf2741f, ; 1012: System.Buffers => 7
	i32 u0xfe42d509, ; 1013: lib_Xamarin.AndroidX.Security.SecurityCrypto.dll.so => 277
	i32 u0xfea12dee, ; 1014: Microsoft.Maui.Controls.dll => 205
	i32 u0xfec99597, ; 1015: CommunityToolkit.Mvvm.dll => 176
	i32 u0xfecef6ea, ; 1016: System.Runtime.Numerics => 111
	i32 u0xff912ee3, ; 1017: lib_System.Xml.Serialization.dll.so => 158
	i32 u0xffd4917f, ; 1018: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 264
	i32 u0xfffce3e8 ; 1019: Xamarin.AndroidX.ExifInterface.dll => 246
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [1020 x i32] [
	i32 69, i32 73, i32 250, i32 68, i32 265, i32 163, i32 109, i32 199,
	i32 191, i32 257, i32 294, i32 48, i32 210, i32 81, i32 334, i32 146,
	i32 298, i32 207, i32 306, i32 30, i32 125, i32 209, i32 179, i32 103,
	i32 10, i32 278, i32 61, i32 336, i32 294, i32 67, i32 108, i32 278,
	i32 140, i32 31, i32 78, i32 125, i32 13, i32 232, i32 229, i32 297,
	i32 186, i32 218, i32 133, i32 280, i32 281, i32 335, i32 290, i32 152,
	i32 160, i32 64, i32 325, i32 335, i32 75, i32 336, i32 18, i32 227,
	i32 44, i32 26, i32 202, i32 250, i32 1, i32 239, i32 60, i32 42,
	i32 323, i32 92, i32 130, i32 214, i32 233, i32 148, i32 253, i32 249,
	i32 307, i32 23, i32 330, i32 55, i32 70, i32 218, i32 84, i32 292,
	i32 117, i32 320, i32 251, i32 13, i32 319, i32 307, i32 132, i32 194,
	i32 196, i32 110, i32 56, i32 192, i32 150, i32 75, i32 146, i32 63,
	i32 193, i32 147, i32 274, i32 339, i32 166, i32 258, i32 123, i32 331,
	i32 234, i32 12, i32 247, i32 126, i32 153, i32 259, i32 171, i32 114,
	i32 167, i32 169, i32 266, i32 165, i32 249, i32 87, i32 266, i32 278,
	i32 116, i32 85, i32 318, i32 312, i32 180, i32 204, i32 125, i32 6,
	i32 151, i32 315, i32 61, i32 200, i32 51, i32 104, i32 115, i32 195,
	i32 40, i32 291, i32 289, i32 121, i32 195, i32 326, i32 190, i32 132,
	i32 11, i32 174, i32 52, i32 21, i32 44, i32 76, i32 120, i32 258,
	i32 239, i32 245, i32 240, i32 94, i32 309, i32 175, i32 82, i32 186,
	i32 184, i32 137, i32 285, i32 22, i32 225, i32 8, i32 51, i32 326,
	i32 297, i32 74, i32 306, i32 156, i32 299, i32 238, i32 155, i32 164,
	i32 93, i32 295, i32 45, i32 321, i32 309, i32 110, i32 131, i32 178,
	i32 130, i32 181, i32 25, i32 215, i32 162, i32 73, i32 56, i32 46,
	i32 98, i32 203, i32 90, i32 240, i32 22, i32 255, i32 146, i32 87,
	i32 43, i32 161, i32 72, i32 271, i32 242, i32 305, i32 3, i32 42,
	i32 64, i32 56, i32 293, i32 16, i32 58, i32 53, i32 151, i32 41,
	i32 333, i32 294, i32 14, i32 262, i32 245, i32 213, i32 106, i32 252,
	i32 210, i32 167, i32 292, i32 251, i32 34, i32 159, i32 299, i32 86,
	i32 32, i32 243, i32 12, i32 337, i32 142, i32 51, i32 311, i32 57,
	i32 275, i32 36, i32 199, i32 308, i32 293, i32 223, i32 35, i32 249,
	i32 59, i32 97, i32 179, i32 261, i32 12, i32 99, i32 204, i32 256,
	i32 190, i32 17, i32 296, i32 165, i32 93, i32 137, i32 217, i32 259,
	i32 202, i32 332, i32 124, i32 212, i32 17, i32 79, i32 83, i32 288,
	i32 65, i32 86, i32 155, i32 154, i32 284, i32 269, i32 312, i32 141,
	i32 101, i32 193, i32 325, i32 225, i32 29, i32 176, i32 52, i32 229,
	i32 148, i32 323, i32 315, i32 289, i32 230, i32 5, i32 209, i32 303,
	i32 279, i32 300, i32 88, i32 283, i32 115, i32 231, i32 299, i32 222,
	i32 242, i32 177, i32 272, i32 86, i32 289, i32 288, i32 62, i32 113,
	i32 316, i32 306, i32 58, i32 275, i32 100, i32 177, i32 173, i32 50,
	i32 0, i32 19, i32 235, i32 112, i32 102, i32 32, i32 3, i32 103,
	i32 84, i32 105, i32 292, i32 252, i32 191, i32 72, i32 4, i32 262,
	i32 38, i32 32, i32 57, i32 104, i32 74, i32 9, i32 124, i32 46,
	i32 224, i32 204, i32 9, i32 43, i32 4, i32 276, i32 315, i32 35,
	i32 310, i32 304, i32 31, i32 227, i32 139, i32 93, i32 94, i32 330,
	i32 313, i32 182, i32 304, i32 49, i32 142, i32 113, i32 303, i32 141,
	i32 2, i32 331, i32 241, i32 16, i32 338, i32 116, i32 293, i32 158,
	i32 77, i32 80, i32 39, i32 265, i32 37, i32 287, i32 226, i32 175,
	i32 245, i32 238, i32 65, i32 139, i32 15, i32 46, i32 157, i32 166,
	i32 117, i32 301, i32 281, i32 290, i32 233, i32 48, i32 71, i32 81,
	i32 127, i32 95, i32 122, i32 150, i32 26, i32 118, i32 255, i32 98,
	i32 28, i32 228, i32 103, i32 328, i32 150, i32 54, i32 170, i32 4,
	i32 99, i32 38, i32 338, i32 33, i32 78, i32 94, i32 280, i32 200,
	i32 106, i32 21, i32 41, i32 223, i32 171, i32 192, i32 104, i32 247,
	i32 149, i32 195, i32 313, i32 211, i32 265, i32 323, i32 296, i32 290,
	i32 300, i32 270, i32 2, i32 317, i32 135, i32 112, i32 285, i32 201,
	i32 334, i32 215, i32 59, i32 96, i32 233, i32 39, i32 226, i32 337,
	i32 25, i32 95, i32 90, i32 191, i32 100, i32 10, i32 211, i32 224,
	i32 172, i32 177, i32 88, i32 49, i32 188, i32 63, i32 77, i32 101,
	i32 320, i32 277, i32 196, i32 47, i32 217, i32 7, i32 316, i32 82,
	i32 261, i32 305, i32 221, i32 214, i32 314, i32 193, i32 319, i32 89,
	i32 254, i32 155, i32 339, i32 248, i32 33, i32 113, i32 117, i32 66,
	i32 83, i32 136, i32 189, i32 20, i32 11, i32 163, i32 134, i32 321,
	i32 3, i32 28, i32 321, i32 322, i32 291, i32 207, i32 112, i32 328,
	i32 100, i32 27, i32 15, i32 211, i32 203, i32 7, i32 201, i32 85,
	i32 59, i32 72, i32 30, i32 301, i32 65, i32 185, i32 178, i32 284,
	i32 144, i32 81, i32 266, i32 329, i32 158, i32 41, i32 263, i32 205,
	i32 118, i32 197, i32 216, i32 313, i32 319, i32 273, i32 324, i32 168,
	i32 332, i32 258, i32 132, i32 76, i32 67, i32 173, i32 220, i32 144,
	i32 241, i32 107, i32 152, i32 312, i32 20, i32 71, i32 253, i32 157,
	i32 333, i32 196, i32 145, i32 122, i32 268, i32 305, i32 128, i32 0,
	i32 188, i32 153, i32 244, i32 154, i32 89, i32 142, i32 324, i32 231,
	i32 96, i32 247, i32 20, i32 14, i32 185, i32 279, i32 136, i32 76,
	i32 60, i32 234, i32 168, i32 255, i32 169, i32 205, i32 15, i32 75,
	i32 138, i32 180, i32 257, i32 6, i32 318, i32 219, i32 23, i32 194,
	i32 257, i32 275, i32 330, i32 214, i32 206, i32 92, i32 1, i32 137,
	i32 260, i32 259, i32 283, i32 135, i32 70, i32 147, i32 114, i32 301,
	i32 25, i32 248, i32 202, i32 89, i32 97, i32 238, i32 243, i32 270,
	i32 31, i32 45, i32 144, i32 253, i32 185, i32 264, i32 216, i32 110,
	i32 159, i32 35, i32 300, i32 108, i32 22, i32 115, i32 58, i32 139,
	i32 281, i32 145, i32 119, i32 121, i32 236, i32 111, i32 311, i32 218,
	i32 140, i32 224, i32 55, i32 181, i32 80, i32 106, i32 181, i32 206,
	i32 8, i32 207, i32 121, i32 134, i32 262, i32 295, i32 288, i32 152,
	i32 286, i32 274, i32 252, i32 9, i32 215, i32 48, i32 248, i32 68,
	i32 183, i32 209, i32 334, i32 160, i32 311, i32 269, i32 235, i32 212,
	i32 5, i32 164, i32 127, i32 133, i32 274, i32 162, i32 324, i32 263,
	i32 188, i32 141, i32 286, i32 42, i32 282, i32 310, i32 170, i32 208,
	i32 175, i32 219, i32 291, i32 40, i32 303, i32 329, i32 246, i32 82,
	i32 184, i32 213, i32 57, i32 37, i32 128, i32 98, i32 167, i32 173,
	i32 302, i32 179, i32 287, i32 83, i32 221, i32 203, i32 99, i32 26,
	i32 30, i32 160, i32 276, i32 18, i32 128, i32 120, i32 242, i32 156,
	i32 260, i32 277, i32 307, i32 182, i32 216, i32 70, i32 256, i32 279,
	i32 166, i32 250, i32 339, i32 105, i32 276, i32 267, i32 170, i32 171,
	i32 16, i32 287, i32 283, i32 145, i32 317, i32 40, i32 126, i32 119,
	i32 38, i32 194, i32 116, i32 47, i32 143, i32 85, i32 118, i32 187,
	i32 34, i32 190, i32 96, i32 53, i32 230, i32 95, i32 267, i32 268,
	i32 129, i32 102, i32 130, i32 154, i32 180, i32 24, i32 162, i32 241,
	i32 149, i32 210, i32 105, i32 251, i32 90, i32 234, i32 228, i32 61,
	i32 143, i32 91, i32 101, i32 5, i32 13, i32 122, i32 123, i32 120,
	i32 136, i32 28, i32 197, i32 73, i32 239, i32 24, i32 24, i32 226,
	i32 272, i32 269, i32 282, i32 237, i32 18, i32 138, i32 219, i32 236,
	i32 169, i32 33, i32 273, i32 102, i32 124, i32 240, i32 92, i32 198,
	i32 164, i32 168, i32 243, i32 39, i32 192, i32 244, i32 184, i32 29,
	i32 316, i32 17, i32 172, i32 329, i32 280, i32 138, i32 151, i32 232,
	i32 189, i32 298, i32 156, i32 131, i32 19, i32 66, i32 295, i32 335,
	i32 165, i32 109, i32 148, i32 1, i32 225, i32 246, i32 47, i32 161,
	i32 304, i32 328, i32 309, i32 217, i32 186, i32 80, i32 0, i32 62,
	i32 213, i32 308, i32 107, i32 271, i32 140, i32 221, i32 273, i32 49,
	i32 254, i32 302, i32 268, i32 14, i32 189, i32 326, i32 310, i32 197,
	i32 69, i32 314, i32 222, i32 172, i32 227, i32 232, i32 322, i32 153,
	i32 338, i32 79, i32 237, i32 109, i32 220, i32 267, i32 68, i32 64,
	i32 133, i32 27, i32 161, i32 34, i32 187, i32 260, i32 271, i32 174,
	i32 147, i32 317, i32 159, i32 229, i32 45, i32 286, i32 10, i32 183,
	i32 200, i32 111, i32 297, i32 11, i32 54, i32 53, i32 174, i32 79,
	i32 119, i32 127, i32 84, i32 199, i32 67, i32 108, i32 228, i32 66,
	i32 231, i32 129, i32 123, i32 78, i32 282, i32 272, i32 337, i32 8,
	i32 236, i32 2, i32 230, i32 60, i32 333, i32 44, i32 285, i32 143,
	i32 157, i32 129, i32 270, i32 208, i32 55, i32 201, i32 23, i32 107,
	i32 134, i32 69, i32 223, i32 256, i32 71, i32 332, i32 235, i32 314,
	i32 36, i32 29, i32 37, i32 222, i32 54, i32 178, i32 63, i32 135,
	i32 52, i32 254, i32 206, i32 302, i32 308, i32 91, i32 187, i32 182,
	i32 88, i32 318, i32 149, i32 320, i32 296, i32 284, i32 183, i32 261,
	i32 208, i32 126, i32 36, i32 87, i32 244, i32 19, i32 327, i32 212,
	i32 327, i32 74, i32 325, i32 322, i32 198, i32 198, i32 50, i32 6,
	i32 91, i32 21, i32 163, i32 97, i32 50, i32 331, i32 114, i32 264,
	i32 131, i32 77, i32 62, i32 220, i32 176, i32 336, i32 27, i32 43,
	i32 298, i32 327, i32 237, i32 263, i32 7, i32 277, i32 205, i32 176,
	i32 111, i32 158, i32 264, i32 246
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 4

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 4

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 u0x0000000000000000, ; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 4

; Functions

; Function attributes: memory(write, argmem: none, inaccessiblemem: none) "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 4, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 1

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { memory(write, argmem: none, inaccessiblemem: none) "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+armv7-a,+d32,+dsp,+fp64,+neon,+vfp2,+vfp2sp,+vfp3,+vfp3d16,+vfp3d16sp,+vfp3sp,-aes,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fullfp16,-sha2,-thumb-mode,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+armv7-a,+d32,+dsp,+fp64,+neon,+vfp2,+vfp2sp,+vfp3,+vfp3d16,+vfp3d16sp,+vfp3sp,-aes,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fullfp16,-sha2,-thumb-mode,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" }

; Metadata
!llvm.module.flags = !{!0, !1, !7}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!".NET for Android remotes/origin/release/9.0.1xx @ 278e101698269c9bc8840aa94d72e7f24066a96d"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"min_enum_size", i32 4}
