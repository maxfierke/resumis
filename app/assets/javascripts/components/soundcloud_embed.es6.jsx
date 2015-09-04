class SoundcloudEmbed extends React.Component {
  getEmbedUrl() {
    var soundCloudBase = "//w.soundcloud.com/player/?url=";

    return soundCloudBase + encodeURIComponent("https://soundcloud.com/" + this.props.url);
  }

  render () {
    return (
      <div className="embed-responsive embed-responsive-16by9">
        <iframe width="100%" height="166" frameBorder="0" src={this.getEmbedUrl()}></iframe>
      </div>
    );
  }
}

SoundcloudEmbed.propTypes = {
  url: React.PropTypes.string
};
