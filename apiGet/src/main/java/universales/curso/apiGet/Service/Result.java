package universales.curso.apiGet.Service;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Result {

	@JsonProperty("wrapperType")
	public String getWrapperType() {
		return this.wrapperType;
	}

	public void setWrapperType(String wrapperType) {
		this.wrapperType = wrapperType;
	}

	String wrapperType;

	@JsonProperty("kind")
	public String getKind() {
		return this.kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	String kind;

	@JsonProperty("artistId")
	public int getArtistId() {
		return this.artistId;
	}

	public void setArtistId(int artistId) {
		this.artistId = artistId;
	}

	int artistId;

	@JsonProperty("collectionId")
	public int getCollectionId() {
		return this.collectionId;
	}

	public void setCollectionId(int collectionId) {
		this.collectionId = collectionId;
	}

	int collectionId;

	@JsonProperty("trackId")
	public int getTrackId() {
		return this.trackId;
	}

	public void setTrackId(int trackId) {
		this.trackId = trackId;
	}

	int trackId;

	@JsonProperty("artistName")
	public String getArtistName() {
		return this.artistName;
	}

	public void setArtistName(String artistName) {
		this.artistName = artistName;
	}

	String artistName;

	@JsonProperty("collectionName")
	public String getCollectionName() {
		return this.collectionName;
	}

	public void setCollectionName(String collectionName) {
		this.collectionName = collectionName;
	}

	String collectionName;

	@JsonProperty("trackName")
	public String getTrackName() {
		return this.trackName;
	}

	public void setTrackName(String trackName) {
		this.trackName = trackName;
	}

	String trackName;

	@JsonProperty("collectionCensoredName")
	public String getCollectionCensoredName() {
		return this.collectionCensoredName;
	}

	public void setCollectionCensoredName(String collectionCensoredName) {
		this.collectionCensoredName = collectionCensoredName;
	}

	String collectionCensoredName;

	@JsonProperty("trackCensoredName")
	public String getTrackCensoredName() {
		return this.trackCensoredName;
	}

	public void setTrackCensoredName(String trackCensoredName) {
		this.trackCensoredName = trackCensoredName;
	}

	String trackCensoredName;

	@JsonProperty("artistViewUrl")
	public String getArtistViewUrl() {
		return this.artistViewUrl;
	}

	public void setArtistViewUrl(String artistViewUrl) {
		this.artistViewUrl = artistViewUrl;
	}

	String artistViewUrl;

	@JsonProperty("collectionViewUrl")
	public String getCollectionViewUrl() {
		return this.collectionViewUrl;
	}

	public void setCollectionViewUrl(String collectionViewUrl) {
		this.collectionViewUrl = collectionViewUrl;
	}

	String collectionViewUrl;

	@JsonProperty("trackViewUrl")
	public String getTrackViewUrl() {
		return this.trackViewUrl;
	}

	public void setTrackViewUrl(String trackViewUrl) {
		this.trackViewUrl = trackViewUrl;
	}

	String trackViewUrl;

	@JsonProperty("previewUrl")
	public String getPreviewUrl() {
		return this.previewUrl;
	}

	public void setPreviewUrl(String previewUrl) {
		this.previewUrl = previewUrl;
	}

	String previewUrl;

	@JsonProperty("artworkUrl30")
	public String getArtworkUrl30() {
		return this.artworkUrl30;
	}

	public void setArtworkUrl30(String artworkUrl30) {
		this.artworkUrl30 = artworkUrl30;
	}

	String artworkUrl30;

	@JsonProperty("artworkUrl60")
	public String getArtworkUrl60() {
		return this.artworkUrl60;
	}

	public void setArtworkUrl60(String artworkUrl60) {
		this.artworkUrl60 = artworkUrl60;
	}

	String artworkUrl60;

	@JsonProperty("artworkUrl100")
	public String getArtworkUrl100() {
		return this.artworkUrl100;
	}

	public void setArtworkUrl100(String artworkUrl100) {
		this.artworkUrl100 = artworkUrl100;
	}

	String artworkUrl100;

	@JsonProperty("collectionPrice")
	public double getCollectionPrice() {
		return this.collectionPrice;
	}

	public void setCollectionPrice(double collectionPrice) {
		this.collectionPrice = collectionPrice;
	}

	double collectionPrice;

	@JsonProperty("trackPrice")
	public double getTrackPrice() {
		return this.trackPrice;
	}

	public void setTrackPrice(double trackPrice) {
		this.trackPrice = trackPrice;
	}

	double trackPrice;

	@JsonProperty("releaseDate")
	public Date getReleaseDate() {
		return this.releaseDate;
	}

	public void setReleaseDate(Date releaseDate) {
		this.releaseDate = releaseDate;
	}

	Date releaseDate;

	@JsonProperty("collectionExplicitness")
	public String getCollectionExplicitness() {
		return this.collectionExplicitness;
	}

	public void setCollectionExplicitness(String collectionExplicitness) {
		this.collectionExplicitness = collectionExplicitness;
	}

	String collectionExplicitness;

	@JsonProperty("trackExplicitness")
	public String getTrackExplicitness() {
		return this.trackExplicitness;
	}

	public void setTrackExplicitness(String trackExplicitness) {
		this.trackExplicitness = trackExplicitness;
	}

	String trackExplicitness;

	@JsonProperty("discCount")
	public int getDiscCount() {
		return this.discCount;
	}

	public void setDiscCount(int discCount) {
		this.discCount = discCount;
	}

	int discCount;

	@JsonProperty("discNumber")
	public int getDiscNumber() {
		return this.discNumber;
	}

	public void setDiscNumber(int discNumber) {
		this.discNumber = discNumber;
	}

	int discNumber;

	@JsonProperty("trackCount")
	public int getTrackCount() {
		return this.trackCount;
	}

	public void setTrackCount(int trackCount) {
		this.trackCount = trackCount;
	}

	int trackCount;

	@JsonProperty("trackNumber")
	public int getTrackNumber() {
		return this.trackNumber;
	}

	public void setTrackNumber(int trackNumber) {
		this.trackNumber = trackNumber;
	}

	int trackNumber;

	@JsonProperty("trackTimeMillis")
	public int getTrackTimeMillis() {
		return this.trackTimeMillis;
	}

	public void setTrackTimeMillis(int trackTimeMillis) {
		this.trackTimeMillis = trackTimeMillis;
	}

	int trackTimeMillis;

	@JsonProperty("country")
	public String getCountry() {
		return this.country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	String country;

	@JsonProperty("currency")
	public String getCurrency() {
		return this.currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	String currency;

	@JsonProperty("primaryGenreName")
	public String getPrimaryGenreName() {
		return this.primaryGenreName;
	}

	public void setPrimaryGenreName(String primaryGenreName) {
		this.primaryGenreName = primaryGenreName;
	}

	String primaryGenreName;

	@JsonProperty("isStreamable")
	public boolean getIsStreamable() {
		return this.isStreamable;
	}

	public void setIsStreamable(boolean isStreamable) {
		this.isStreamable = isStreamable;
	}

	boolean isStreamable;

}
