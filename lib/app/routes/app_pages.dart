import 'package:get/get.dart';

import '../modules/community/bindings/community_binding.dart';
import '../modules/community/detailCommunity/bindings/detail_community_binding.dart';
import '../modules/community/detailCommunity/views/detail_community_view.dart';
import '../modules/community/documentsCommunity/bindings/documents_community_binding.dart';
import '../modules/community/documentsCommunity/views/documents_community_view.dart';
import '../modules/community/fileCommunity/bindings/file_community_binding.dart';
import '../modules/community/fileCommunity/views/file_community_view.dart';
import '../modules/community/formCommunity/bindings/form_community_binding.dart';
import '../modules/community/formCommunity/views/form_community_view.dart';
import '../modules/community/views/community_view.dart';
import '../modules/courses/bindings/courses_binding.dart';
import '../modules/courses/courseBdpDetail/bindings/course_bdp_detail_binding.dart';
import '../modules/courses/courseBdpDetail/views/course_bdp_detail_view.dart';
import '../modules/courses/courseBdpModule/bindings/course_bdp_module_binding.dart';
import '../modules/courses/courseBdpModule/views/course_bdp_module_view.dart';
import '../modules/courses/courseBdpTopic/bindings/course_bdp_topic_binding.dart';
import '../modules/courses/courseBdpTopic/views/course_bdp_topic_view.dart';
import '../modules/courses/courseDetail/bindings/course_detail_binding.dart';
import '../modules/courses/courseDetail/views/course_detail_view.dart';
import '../modules/courses/views/courses_view.dart';
import '../modules/faq/bindings/faq_binding.dart';
import '../modules/faq/views/faq_view.dart';
import '../modules/goodPractices/bindings/good_practices_binding.dart';
import '../modules/goodPractices/resources/bindings/resources_binding.dart';
import '../modules/goodPractices/resources/document/bindings/document_binding.dart';
import '../modules/goodPractices/resources/document/views/document_view.dart';
import '../modules/goodPractices/resources/video/bindings/video_binding.dart';
import '../modules/goodPractices/resources/video/views/video_view.dart';
import '../modules/goodPractices/resources/views/resources_view.dart';
import '../modules/goodPractices/views/good_practices_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/pathologies/bindings/pathologies_binding.dart';
import '../modules/pathologies/documentPathology/bindings/document_pathology_binding.dart';
import '../modules/pathologies/documentPathology/views/document_pathology_view.dart';
import '../modules/pathologies/pathology/bindings/pathology_binding.dart';
import '../modules/pathologies/pathology/views/pathology_view.dart';
import '../modules/pathologies/views/pathologies_view.dart';
import '../modules/prices/bindings/prices_binding.dart';
import '../modules/prices/views/prices_view.dart';
import '../modules/production/bindings/production_binding.dart';
import '../modules/production/views/production_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/quiz/bindings/quiz_binding.dart';
import '../modules/quiz/views/quiz_view.dart';
import '../modules/quotes/bindings/quotes_binding.dart';
import '../modules/quotes/pdfQuote/bindings/pdf_quote_binding.dart';
import '../modules/quotes/pdfQuote/views/pdf_quote_view.dart';
import '../modules/quotes/views/quotes_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/supplier/bindings/supplier_binding.dart';
import '../modules/supplier/views/supplier_view.dart';
import '../modules/suppliers/bindings/suppliers_binding.dart';
import '../modules/suppliers/views/suppliers_view.dart';
import '../modules/weather/bindings/weather_binding.dart';
import '../modules/weather/views/weather_view.dart';
import 'middlewares/auth_middleware.dart';
import 'middlewares/no_auth_middleware.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      middlewares: [
        NoAuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.FAQ,
      page: () => const FaqView(),
      binding: FaqBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.SUPPLIERS,
      page: () => const SuppliersView(),
      binding: SuppliersBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.SUPPLIER,
      page: () => const SupplierView(),
      binding: SupplierBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.COURSES,
      page: () => const CoursesView(),
      binding: CoursesBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
      children: [
        GetPage(
          name: _Paths.COURSE_DETAIL,
          page: () => const CourseDetailView(),
          binding: CourseDetailBinding(),
        ),
        GetPage(
          name: _Paths.COURSE_BDP_DETAIL,
          page: () => const CourseBdpDetailView(),
          binding: CourseBdpDetailBinding(),
        ),
        GetPage(
          name: _Paths.COURSE_BDP_TOPIC,
          page: () => const CourseBdpTopicView(),
          binding: CourseBdpTopicBinding(),
        ),
        GetPage(
          name: _Paths.COURSE_BDP_MODULE,
          page: () => const CourseBdpModuleView(),
          binding: CourseBdpModuleBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.GOOD_PRACTICES,
      page: () => const GoodPracticesView(),
      binding: GoodPracticesBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
      children: [
        GetPage(
          name: _Paths.RESOURCES,
          page: () => const ResourcesView(),
          binding: ResourcesBinding(),
          children: [
            GetPage(
              name: _Paths.VIDEO,
              page: () => const VideoView(),
              binding: VideoBinding(),
            ),
            GetPage(
              name: _Paths.DOCUMENT,
              page: () => const DocumentView(),
              binding: DocumentBinding(),
            ),
          ],
        ),
      ],
    ),
    GetPage(
      name: _Paths.QUOTES,
      page: () => const QuotesView(),
      binding: QuotesBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
      children: [
        GetPage(
          name: _Paths.PDF_QUOTE,
          page: () => const PdfQuoteView(),
          binding: PdfQuoteBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.PATHOLOGIES,
      page: () => const PathologiesView(),
      binding: PathologiesBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
      children: [
        GetPage(
          name: _Paths.PATHOLOGY,
          page: () => const PathologyView(),
          binding: PathologyBinding(),
        ),
        GetPage(
          name: _Paths.DOCUMENT_PATHOLOGY,
          page: () => const DocumentPathologyView(),
          binding: DocumentPathologyBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.COMMUNITY,
      page: () => const CommunityView(),
      binding: CommunityBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
      children: [
        GetPage(
          name: _Paths.DETAIL_COMMUNITY,
          page: () => const DetailCommunityView(),
          binding: DetailCommunityBinding(),
        ),
        GetPage(
          name: _Paths.FORM_COMMUNITY,
          page: () => const FormCommunityView(),
          binding: FormCommunityBinding(),
        ),
        GetPage(
          name: _Paths.DOCUMENTS_COMMUNITY,
          page: () => const DocumentsCommunityView(),
          binding: DocumentsCommunityBinding(),
        ),
        GetPage(
          name: _Paths.FILE_COMMUNITY,
          page: () => const FileCommunityView(),
          binding: FileCommunityBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.WEATHER,
      page: () => const WeatherView(),
      binding: WeatherBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.PRICES,
      page: () => const PricesView(),
      binding: PricesBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.PRODUCTION,
      page: () => const ProductionView(),
      binding: ProductionBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.QUIZ,
      page: () => const QuizView(),
      binding: QuizBinding(),
    ),
  ];
}
