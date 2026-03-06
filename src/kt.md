# Kotlin

> modern android development. concise and safe.

---

## basics

```kotlin
// variables
val name = "abhishek"    // immutable (like const)
var age = 20             // mutable

// explicit type
val name: String = "abhishek"
var count: Int = 0

// nullable
var email: String? = null      // can be null
var email: String = "a@b.com"  // cannot be null

// null safety
email?.length              // safe call, null if email is null
email ?: "no email"        // elvis operator, default if null
email!!.length             // force unwrap, throws if null (avoid)
```

---

## data types

```kotlin
val i: Int = 42
val l: Long = 42L
val f: Float = 3.14f
val d: Double = 3.14
val b: Boolean = true
val c: Char = 'A'
val s: String = "hello"
val bytes: ByteArray = byteArrayOf(1, 2, 3)

// type conversion
42.toString()
"42".toInt()
"3.14".toDouble()
42.toLong()
```

---

## strings

```kotlin
val name = "abhishek"
val greeting = "hello $name"
val expr = "age is ${age + 1}"

// raw string
val text = """
    line one
    line two
""".trimIndent()

// methods
name.length
name.uppercase()
name.lowercase()
name.trim()
name.contains("abhi")
name.startsWith("ab")
name.endsWith("ek")
name.replace("abhi", "xyz")
name.split(",")
name.substring(0, 4)
name.isEmpty()
name.isBlank()
```

---

## collections

```kotlin
// list
val list = listOf(1, 2, 3)          // immutable
val mList = mutableListOf(1, 2, 3)  // mutable

mList.add(4)
mList.remove(1)
mList.removeAt(0)
mList[0] = 10

// map
val map = mapOf("name" to "abhi", "age" to 20)
val mMap = mutableMapOf("name" to "abhi")

mMap["email"] = "a@b.com"
mMap.remove("name")
map["name"]            // "abhi"
map.getOrDefault("x", "default")
map.containsKey("name")

// set
val set = setOf(1, 2, 3)
val mSet = mutableSetOf(1, 2, 3)
mSet.add(4)

// collection operations
list.filter { it > 2 }       // [3]
list.map { it * 2 }          // [2, 4, 6]
list.find { it > 2 }         // 3
list.any { it > 2 }          // true
list.all { it > 0 }          // true
list.none { it < 0 }         // true
list.count { it > 1 }        // 2
list.sum()                   // 6
list.sortedBy { it }
list.sortedByDescending { it }
list.forEach { println(it) }
list.reduce { acc, i -> acc + i }
list.groupBy { it % 2 }
list.first()
list.last()
list.firstOrNull()
list.take(2)
list.drop(2)
list.distinct()
list.flatten()
```

---

## functions

```kotlin
// basic
fun greet(name: String): String {
    return "hello $name"
}

// single expression
fun greet(name: String) = "hello $name"

// default params
fun greet(name: String = "stranger") = "hello $name"

// named args
greet(name = "abhishek")

// vararg
fun sum(vararg numbers: Int) = numbers.sum()
sum(1, 2, 3)

// extension function
fun String.shout() = uppercase() + "!!!"
"hello".shout()  // "HELLO!!!"

// higher order function
fun apply(value: Int, operation: (Int) -> Int): Int {
    return operation(value)
}
apply(5) { it * 2 }  // 10

// lambda
val double = { x: Int -> x * 2 }
val add = { a: Int, b: Int -> a + b }
```

---

## classes

```kotlin
// basic class
class User(val name: String, var age: Int) {
    val displayName get() = name.uppercase()

    fun greet() = "hello, i'm $name"
}

val user = User("abhishek", 20)
user.name    // "abhishek"
user.age = 21
user.greet()

// data class (for models)
data class User(
    val id: Int,
    val name: String,
    val email: String
)
// auto generates: equals, hashCode, toString, copy

val user = User(1, "abhishek", "a@b.com")
val updated = user.copy(age = 21)

// sealed class (for state)
sealed class Result<out T> {
    data class Success<T>(val data: T) : Result<T>()
    data class Error(val message: String) : Result<Nothing>()
    object Loading : Result<Nothing>()
}

// object (singleton)
object Database {
    val connection = "connected"
    fun query(sql: String) = "result"
}
Database.query("SELECT *")

// companion object (static methods)
class User {
    companion object {
        fun create(name: String) = User(name)
    }
}
User.create("abhishek")

// interface
interface Clickable {
    fun onClick()
    fun onLongClick() {}  // default implementation
}

// inheritance
open class Animal(val name: String) {
    open fun sound() = "..."
}

class Dog(name: String) : Animal(name) {
    override fun sound() = "woof"
}
```

---

## control flow

```kotlin
// if/else (expression)
val label = if (age > 18) "adult" else "minor"

// when (like switch but better)
when (status) {
    "active" -> println("active")
    "inactive" -> println("inactive")
    else -> println("unknown")
}

// when as expression
val label = when {
    age > 18 -> "adult"
    age > 13 -> "teen"
    else -> "child"
}

// when with type check
when (obj) {
    is String -> println("string: $obj")
    is Int -> println("int: $obj")
    else -> println("other")
}
```

---

## loops

```kotlin
for (i in 1..5) {}        // 1 to 5 inclusive
for (i in 1 until 5) {}   // 1 to 4
for (i in 5 downTo 1) {}  // 5 to 1
for (i in 1..10 step 2) {} // 1,3,5,7,9

for (item in list) {}
for ((index, item) in list.withIndex()) {}
for ((key, value) in map) {}

while (condition) {}
do {} while (condition)

repeat(5) { println(it) }
```

---

## coroutines (async)

```kotlin
// add to build.gradle
// implementation "org.jetbrains.kotlinx:kotlinx-coroutines-android:1.7.3"

import kotlinx.coroutines.*

// launch (fire and forget)
CoroutineScope(Dispatchers.IO).launch {
    val data = fetchData()
    withContext(Dispatchers.Main) {
        // update UI on main thread
        updateUI(data)
    }
}

// async/await (get result)
val result = async { fetchData() }
val data = result.await()

// in viewmodel
viewModelScope.launch {
    try {
        val data = repository.getData()
        _uiState.value = UiState.Success(data)
    } catch (e: Exception) {
        _uiState.value = UiState.Error(e.message)
    }
}

// dispatchers
Dispatchers.Main    // UI thread
Dispatchers.IO      // network/disk
Dispatchers.Default // CPU intensive
```

---

## android basics

```kotlin
// Activity
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    override fun onStart() { super.onStart() }
    override fun onResume() { super.onResume() }
    override fun onPause() { super.onPause() }
    override fun onStop() { super.onStop() }
    override fun onDestroy() { super.onDestroy() }
}

// Fragment
class HomeFragment : Fragment(R.layout.fragment_home) {
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        // setup views here
    }
}

// Intent (navigate between activities)
val intent = Intent(this, ProfileActivity::class.java)
intent.putExtra("userId", 123)
startActivity(intent)

// get extra
val userId = intent.getIntExtra("userId", 0)

// implicit intent
val intent = Intent(Intent.ACTION_VIEW, Uri.parse("https://example.com"))
startActivity(intent)
```

---

## Jetpack Compose basics

```kotlin
// composable function
@Composable
fun Greeting(name: String) {
    Text(text = "hello $name")
}

// state
@Composable
fun Counter() {
    var count by remember { mutableStateOf(0) }

    Column {
        Text("Count: $count")
        Button(onClick = { count++ }) {
            Text("Increment")
        }
    }
}

// layout
Column(
    modifier = Modifier.fillMaxSize().padding(16.dp),
    horizontalAlignment = Alignment.CenterHorizontally
) {
    Text("Title", style = MaterialTheme.typography.headlineMedium)
    Spacer(modifier = Modifier.height(8.dp))
    Button(onClick = {}) { Text("Click me") }
}

Row(
    modifier = Modifier.fillMaxWidth(),
    horizontalArrangement = Arrangement.SpaceBetween
) {}

Box(modifier = Modifier.fillMaxSize()) {
    // overlapping elements
}

// modifier
Modifier
    .fillMaxSize()
    .fillMaxWidth()
    .fillMaxHeight()
    .size(100.dp)
    .width(100.dp)
    .height(100.dp)
    .padding(16.dp)
    .background(Color.Blue)
    .clip(RoundedCornerShape(8.dp))
    .border(1.dp, Color.Gray)
    .clickable {}
    .alpha(0.5f)

// lazy list (like RecyclerView)
LazyColumn {
    items(userList) { user ->
        UserCard(user)
    }
}

LazyRow {
    items(userList) { user ->
        UserCard(user)
    }
}
```

---

## ViewModel

```kotlin
class HomeViewModel : ViewModel() {
    private val _users = MutableStateFlow<List<User>>(emptyList())
    val users: StateFlow<List<User>> = _users.asStateFlow()

    private val _loading = MutableStateFlow(false)
    val loading: StateFlow<Boolean> = _loading.asStateFlow()

    init {
        loadUsers()
    }

    private fun loadUsers() {
        viewModelScope.launch {
            _loading.value = true
            try {
                _users.value = repository.getUsers()
            } catch (e: Exception) {
                // handle error
            } finally {
                _loading.value = false
            }
        }
    }
}

// in composable
@Composable
fun HomeScreen(viewModel: HomeViewModel = viewModel()) {
    val users by viewModel.users.collectAsState()
    val loading by viewModel.loading.collectAsState()
}
```

---

## Room database

```kotlin
// entity
@Entity(tableName = "messages")
data class Message(
    @PrimaryKey(autoGenerate = true) val id: Int = 0,
    val text: String,
    val timestamp: Long = System.currentTimeMillis()
)

// DAO
@Dao
interface MessageDao {
    @Query("SELECT * FROM messages ORDER BY timestamp DESC")
    fun getAllMessages(): Flow<List<Message>>

    @Insert
    suspend fun insert(message: Message)

    @Delete
    suspend fun delete(message: Message)

    @Update
    suspend fun update(message: Message)
}

// database
@Database(entities = [Message::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun messageDao(): MessageDao
}

// create
val db = Room.databaseBuilder(
    context,
    AppDatabase::class.java,
    "app-database"
).build()
```

---

## encryption (for private chat app)

```kotlin
// add dependency
// implementation "androidx.security:security-crypto:1.1.0-alpha06"

import androidx.security.crypto.EncryptedSharedPreferences
import androidx.security.crypto.MasterKey
import javax.crypto.Cipher
import android.security.keystore.KeyGenParameterSpec
import android.security.keystore.KeyProperties

// encrypted shared preferences
val masterKey = MasterKey.Builder(context)
    .setKeyScheme(MasterKey.KeyScheme.AES256_GCM)
    .build()

val prefs = EncryptedSharedPreferences.create(
    context,
    "secret_prefs",
    masterKey,
    EncryptedSharedPreferences.PrefKeyEncryptionScheme.AES256_SIV,
    EncryptedSharedPreferences.PrefValueEncryptionScheme.AES256_GCM
)

prefs.edit().putString("token", "secret").apply()
prefs.getString("token", null)

// AES encryption
fun encrypt(data: String, key: SecretKey): ByteArray {
    val cipher = Cipher.getInstance("AES/GCM/NoPadding")
    cipher.init(Cipher.ENCRYPT_MODE, key)
    return cipher.doFinal(data.toByteArray())
}

fun decrypt(data: ByteArray, key: SecretKey, iv: ByteArray): String {
    val cipher = Cipher.getInstance("AES/GCM/NoPadding")
    cipher.init(Cipher.DECRYPT_MODE, key, GCMParameterSpec(128, iv))
    return String(cipher.doFinal(data))
}
```

---

## build.gradle (app level)

```kotlin
android {
    compileSdk 34
    defaultConfig {
        minSdk 21   // Android 5.0
        targetSdk 34
    }
}

dependencies {
    // core
    implementation "androidx.core:core-ktx:1.12.0"
    implementation "androidx.appcompat:appcompat:1.6.1"

    // compose
    implementation platform("androidx.compose:compose-bom:2024.01.00")
    implementation "androidx.compose.ui:ui"
    implementation "androidx.compose.material3:material3"
    implementation "androidx.activity:activity-compose:1.8.2"

    // viewmodel
    implementation "androidx.lifecycle:lifecycle-viewmodel-compose:2.7.0"

    // coroutines
    implementation "org.jetbrains.kotlinx:kotlinx-coroutines-android:1.7.3"

    // room
    implementation "androidx.room:room-runtime:2.6.1"
    implementation "androidx.room:room-ktx:2.6.1"
    kapt "androidx.room:room-compiler:2.6.1"

    // network
    implementation "com.squareup.retrofit2:retrofit:2.9.0"
    implementation "com.squareup.retrofit2:converter-gson:2.9.0"
    implementation "com.squareup.okhttp3:okhttp:4.12.0"

    // encrypted storage
    implementation "androidx.security:security-crypto:1.1.0-alpha06"
}
```

---

```
=^._.^= kotlin makes android fun
```
