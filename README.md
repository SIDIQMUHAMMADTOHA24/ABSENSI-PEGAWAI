lib/
├─ core/ # hal umum (dipakai lintas fitur)
│ └─ dio_client.dart # builder Dio (baseUrl, timeout, header)
└─ features/
└─ auth/
├─ domain/ # aturan bisnis (murni, tanpa Dio/Flutter)
│ ├─ entities/
│ │ ├─ user.dart
│ │ └─ auth_result.dart
│ ├─ repositories/
│ │ └─ auth_repository.dart # kontrak "apa" yg bisa dilakukan
│ └─ usecases/
│ ├─ login.dart # 1 use case = 1 aksi bisnis
│ └─ register.dart
├─ data/ # “bagaimana” ambil data (API/DB)
│ ├─ datasources/
│ │ └─ auth_remote_data_source.dart # call Dio ke /login, /register
│ ├─ models/
│ │ ├─ user_model.dart
│ │ └─ auth_result_model.dart # mapping JSON ↔ entity
│ └─ repositories/
│ └─ auth_repository_impl.dart # implement kontrak pakai data source
└─ presentation/ # layer UI / state
└─ bloc/
├─ auth_bloc.dart
├─ auth_event.dart # hanya LoginSubmitted & RegisterSubmitted
└─ auth_state.dart

Kenapa dipisah begitu?

domain = pusat aturan bisnis (bebas framework). Enaknya: gampang dites & ganti data source.

data = urusan IO (Dio, database, cache) + mapping ke entity domain.

presentation = state/Bloc + widget. Cuma tahu use case, gak tahu Dio.

core = util/konfigurasi umum lintas fitur (Dio, logger, constants).

Intinya: UI ngomong ke UseCase, UseCase ngomong ke Repository (kontrak), lalu RepositoryImpl pakai DataSource (Dio).
