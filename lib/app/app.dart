import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/pages/sign_in_page.dart';
import 'di.dart';

class MusicOLApp extends ConsumerWidget {
  const MusicOLApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = _createRouter(ref);
    
    return MaterialApp.router(
      title: 'MusicOL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }

  GoRouter _createRouter(WidgetRef ref) {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/sign-in',
          builder: (context, state) => const SignInPage(),
        ),
      ],
      redirect: (context, state) {
        final authState = ref.read(authStateProvider);
        final isSignedIn = authState.valueOrNull != null;
        final isSignInRoute = state.matchedLocation == '/sign-in';
        
        // If not signed in and not on sign-in page, redirect to sign-in
        if (!isSignedIn && !isSignInRoute) {
          return '/sign-in';
        }
        
        // If signed in and on sign-in page, redirect to home
        if (isSignedIn && isSignInRoute) {
          return '/';
        }
        
        return null;
      },
    );
  }
}

// Temporary Home Page
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('MusicOL'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(signOutProvider)();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Chào mừng đến với MusicOL!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            authState.when(
              data: (user) => user != null
                  ? Column(
                      children: [
                        if (user.photoUrl != null)
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(user.photoUrl!),
                          ),
                        const SizedBox(height: 8),
                        Text('Xin chào, ${user.displayName ?? user.email}!'),
                        Text('Roles: ${user.roles.join(', ')}'),
                      ],
                    )
                  : const Text('Người dùng chưa đăng nhập'),
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text('Lỗi: $error'),
            ),
          ],
        ),
      ),
    );
  }
}