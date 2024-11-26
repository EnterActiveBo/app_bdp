import 'package:appbdp/app/common/storage_box.dart';
import 'package:appbdp/app/common/widgets/loader_widgets.dart';
import 'package:appbdp/app/models/community_model.dart';
import 'package:appbdp/app/models/providers/community_provider.dart';
import 'package:appbdp/app/models/providers/user_provider.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:appbdp/app/modules/community/detailCommunity/controllers/detail_community_controller.dart';
import 'package:appbdp/app/modules/community/formCommunity/controllers/form_community_controller.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CommunityController extends GetxController {
  GetStorage box = GetStorage('App');
  final UserProvider userProvider = Get.find();
  String userKey = 'user';
  final Rx<UserModel?> user = (null as UserModel?).obs;
  String communitiesKey = 'communities';
  final CommunityProvider communityProvider = Get.find();
  final DetailCommunityController detailCommunityController =
      Get.put<DetailCommunityController>(
    DetailCommunityController(),
    permanent: true,
  );
  final FormCommunityController formCommunityController =
      Get.put<FormCommunityController>(
    FormCommunityController(),
    permanent: true,
  );
  final Rx<CommunityListModel?> communityList =
      (null as CommunityListModel?).obs;
  final RxList<CommunityModel> communities = (List<CommunityModel>.of([])).obs;
  final RxList<TagCommunityModel> tags = (List<TagCommunityModel>.of([])).obs;
  final Rx<String?> search = (null as String?).obs;
  final RxList<String> tagsSelected = (List<String>.of([])).obs;
  final activeSearch = false.obs;
  final newsPerPage = 10.obs;
  final currentPage = 1.obs;
  final loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  @override
  void onClose() {
    search.value = null;
    activeSearch.value = false;
    loading.value = true;
    super.onClose();
  }

  initData() {
    initUser();
    communities.value = communitiesStored(box);
    getCommunityList();
    getTags();
  }

  getCommunityList() async {
    loading.value = true;
    Map<String, dynamic> query = getQuery();
    CommunityListModel? communityListResponse =
        await communityProvider.getCommunities(
      query: query,
    );
    loading.value = false;
    if (communityListResponse is CommunityListModel) {
      communityList.value = communityListResponse;
      if (communityListResponse.meta.currentPage == 1 &&
          (activeSearch.value == false || tagsSelected.isEmpty)) {
        communities.value = communityListResponse.data;
        box.write(communitiesKey, communityListResponse.data);
      } else {
        if ((activeSearch.value || tagsSelected.isNotEmpty) &&
            currentPage.value == 1) {
          communities.value = communityListResponse.data;
        } else {
          communities.addAll(communityListResponse.data);
          removeDuplicates();
        }
      }
    }
  }

  removeDuplicates() {
    final ids = communities.map((item) => item.id).toSet();
    communities.retainWhere(
      (item) => ids.remove(item.id),
    );
  }

  Map<String, dynamic> getQuery() {
    Map<String, dynamic> query = {
      "page": currentPage.toString(),
      "limit": newsPerPage.toString(),
      "title": search.value,
      // "tags[]": tagsSelected.isNotEmpty ? tagsSelected.join("&tags[]=") : null,
      "tags[]": tagsSelected.isNotEmpty ? tagsSelected : null,
    };
    query.removeWhere((key, value) => value == null);
    return query;
  }

  getTags() async {
    List<TagCommunityModel>? response = await communityProvider.getTags();
    if (response is List<TagCommunityModel>) {
      tags.value = response;
      tags.refresh();
    }
  }

  setTagSelected(String value) {
    if (tagsSelected.contains(value)) {
      tagsSelected.remove(value);
    } else {
      tagsSelected.add(value);
    }
    tagsSelected.refresh();
    currentPage.value = 1;
    getCommunityList();
  }

  cleanTagsSelected() {
    tagsSelected.clear();
    tagsSelected.refresh();
    currentPage.value = 1;
    getCommunityList();
  }

  setSearch(String? value) {
    search.value = value == "" ? null : value;
    currentPage.value = 1;
  }

  findCommunity() {
    if (search.value is String) {
      activeSearch.value = true;
      getCommunityList();
    }
  }

  cleanSearch() {
    search.value = null;
    activeSearch.value = false;
    currentPage.value = 1;
    getCommunityList();
  }

  getNextPage() {
    if (communityList.value is CommunityListModel) {
      if (communityList.value!.meta.currentPage <
          communityList.value!.meta.lastPage) {
        currentPage.value = communityList.value!.meta.currentPage + 1;
        getCommunityList();
      }
    }
  }

  setCommunity(CommunityModel value) {
    detailCommunityController.setCommunity(
      value,
      tagsValue: tags,
    );
    Get.toNamed(Routes.DETAIL_COMMUNITY);
  }

  setCommunityForm({
    CommunityModel? value,
  }) {
    formCommunityController.setCommunity(
      value: value,
      tagsValue: tags,
    );
    Get.toNamed(Routes.FORM_COMMUNITY);
  }

  initUser() {
    user.value = userStored(box);
    getUser();
  }

  getUser() async {
    UserModel? userResponse = await userProvider.getProfile();
    if (userResponse is UserModel) {
      user.value = userResponse;
      box.write(userKey, userResponse);
    }
  }

  setVote(bool value, int index) async {
    Get.dialog(
      barrierDismissible: false,
      loadingDialog(),
    );
    communities[index].meta.positive = value;
    communities[index].meta.negative = !value;
    box.write(communitiesKey, communities);
    communities.refresh();
    await communityProvider.voteCommunity(
      communities[index].id,
      {
        "vote": value,
      },
    );
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}
